//
//  TeamsResponse.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 10/11/2022.
//

import Foundation

// MARK: - TeamResponse
public struct TeamResponse: Codable {
    public private(set) var teams: [Team] = []

    public init(teams: [Team]) {
        self.teams = teams
    }
}
