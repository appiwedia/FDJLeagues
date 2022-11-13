//
//  TeamDetailViewController.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 11/11/2022.
//

import UIKit
import Kingfisher

class TeamDetailViewController: UIViewController {

    var viewModel: TeamDetailViewModel?

    @IBOutlet weak var bannerImageView: UIImageView!

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var teamDescriptionLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Private
    private func setupView() {
        activityIndicatorView.stopAnimating()
        
        navigationItem.title = viewModel?.team?.name
        countryLabel.text = viewModel?.team?.country
        leagueLabel.text = viewModel?.team?.league
        teamDescriptionLabel.text = viewModel?.team?.descriptionEN

        bannerImageView.isHidden = viewModel?.team?.bannerImageUrl == nil

        bannerImageView.kf.indicatorType = .activity
        bannerImageView.kf.setImage(with: viewModel?.team?.bannerImageUrl)
    }
}
