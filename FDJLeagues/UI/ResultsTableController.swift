import UIKit

// This protocol helps inform LeaguesViewController that a league was selected.
protocol ResultsTableControllerDelegate: AnyObject {
    // A league was selected; inform our delgeate that a league was selected to view.
    func didSelectLeague(league: League)
}

class ResultsTableController: UITableViewController {

    static let leagueCellIdentifier = "leagueCell"

    var filteredLeagues = [League]() {
        didSet {
            tableView.reloadData()
        }
    }
    weak var searchDelegate: ResultsTableControllerDelegate?

    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLeagues.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: Self.leagueCellIdentifier)

        let league = filteredLeagues[indexPath.row]
        cell.textLabel?.text = league.name
        cell.textLabel?.textColor = .blue
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let searchDelegate = searchDelegate else { return }
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedLeague = filteredLeagues[indexPath.row]
        searchDelegate.didSelectLeague(league: selectedLeague)
    }
}

