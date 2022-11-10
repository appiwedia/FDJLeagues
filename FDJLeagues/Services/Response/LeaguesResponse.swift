//
//  LeaguesResponse.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 10/11/2022.
//

import Foundation

// MARK: - LeaguesResponse
public struct LeaguesResponse: Codable {
    public let leagues: [League]?

    public init(leagues: [League]?) {
        self.leagues = leagues
    }
}
