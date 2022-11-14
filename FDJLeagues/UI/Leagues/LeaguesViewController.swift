//
//  LeaguesViewController.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 10/11/2022.
//

import UIKit
import Combine
import FDJLeagueKit

class LeaguesViewController: UIViewController {
    
    // MARK: - Properties
    private var disposalBag = Set<AnyCancellable>()

    /// Search controller to help us with filtering.
    var searchController: UISearchController!

    /// The search results table view.
    var resultsTableController: ResultsTableController!

    private let viewModel = LeaguesViewModel()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    static let teamSegue = "teamDetail"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupObservers()
    }
    
    // MARK: - Private
    private func setupView() {

        collectionView.collectionViewLayout = createLayout()
        /// Setup ResultsTableView for completion
        resultsTableController = ResultsTableController()
        resultsTableController.searchDelegate = self

        searchController = UISearchController(searchResultsController: resultsTableController)

        // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController

        searchController.searchBar.placeholder = NSLocalizedString("Search by league", comment: "Placeholder name for search")
        searchController.searchResultsUpdater = self
        searchController.showsSearchResultsController = true

        title = "Football Leagues"
        definesPresentationContext = true

        // Monitor when the search button is tapped, and start/end editing.
        searchController.searchBar.delegate = self
    }
    
    private func setupObservers() {

        viewModel.searchTextPublisher
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] text in
                if self?.isSearchBarEmpty == false  {
                    guard let filteredLeagues = self?.viewModel.filterLeaguesForSearchText(text) else { return }
                    self?.resultsTableController.filteredLeagues = filteredLeagues
                    self?.searchController.showsSearchResultsController = true
                }
            })
            .store(in: &disposalBag)
    }

    // MARK: - CollectionView

    enum Section {
        case main
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Team>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Team>

    private lazy var dataSource = makeDataSource()

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, team) ->
                UICollectionViewCell? in

                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TeamCell.reuseIdentifier,
                    for: indexPath) as? TeamCell
                cell?.updateCell(with: team)
                return cell
            })
        return dataSource
    }

    // 1
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.teams)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    fileprivate func startLoading() {
        self.activityIndicatorView.startAnimating()
        self.collectionView.isHidden = true
    }

    fileprivate func showResults() {
        self.activityIndicatorView.stopAnimating()
        self.collectionView.isHidden = false
    }

    fileprivate func showError(_ error: Error) {
        // TODO: Error management need to be implemented

        self.activityIndicatorView.stopAnimating()
        self.collectionView.isHidden = false
    }

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let teamDetailViewController = segue.destination as? TeamDetailViewController, let team = sender as? Team else { return }

        let teamViewModel = TeamDetailViewModel(team: team)
        teamDetailViewController.viewModel = teamViewModel
    }
}

extension LeaguesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let indexPath = collectionView.indexPathsForSelectedItems?.first {

            let selectedTeam = viewModel.teams[indexPath.row]
            Task {
                do {
                    let team = try await viewModel.fetchTeamDetail(for: selectedTeam)
                    self.performSegue(withIdentifier: Self.teamSegue, sender: team)
                } catch {
                    print(error)
                }
            }
        }
    }
}
extension LeaguesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        viewModel.searchText = searchText
    }
}

extension LeaguesViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.showsSearchResultsController = false
    }
}

extension LeaguesViewController: ResultsTableControllerDelegate {
    func didSelectLeague(league: League) {
        viewModel.resetFilters()
        searchController.showsSearchResultsController = false
        searchController.searchBar.resignFirstResponder()

        Task {
            do {
                startLoading()
                let _ = try await viewModel.fetchTeams(for: league)
                applySnapshot(animatingDifferences: false)
                showResults()
                self.navigationItem.title = league.name
            } catch {
                showError(error)
            }
        }
    }
}
