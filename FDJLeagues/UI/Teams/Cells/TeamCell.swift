//
//  TeamCell.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 13/11/2022.
//

import UIKit
import Kingfisher
import FDJLeagueKit

class TeamCell: UICollectionViewCell {
    static let reuseIdentifier = "teamCell"

    var team: Team?

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamName: UILabel!

    func updateCell(with team: Team) {
        self.team = team
        guard let team = self.team else { return }

        if team.badgeImageUrl == nil {
            showTeamName()
        } else {
            showImage()
        }
    }

    private func showTeamName() {
        teamName.text = team?.name
        teamImageView.isHidden = true
    }

    private func showImage() {
        teamName.text = nil
        teamImageView.isHidden = false

        teamImageView.kf.indicatorType = .activity

        teamImageView.kf.setImage(with: team?.badgeImageUrl, placeholder: nil, options: nil) { result in
            switch result {

            case .success(_):
                break
            case .failure(_):
                self.showTeamName()
            }
        }
    }

}
