//
//  TeamDetailViewModel.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 13/11/2022.
//

import Foundation

class TeamDetailViewModel: ObservableObject {
    private(set) var team: Team?

    init(team: Team) {
        self.team = team
    }
}
