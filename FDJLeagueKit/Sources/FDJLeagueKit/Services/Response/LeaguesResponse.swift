//
//  LeaguesResponse.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 10/11/2022.
//

import Foundation

// MARK: - LeaguesResponse
public struct LeaguesResponse: Codable {
    public private(set) var leagues: [League] = []

    public init(leagues: [League]) {
        self.leagues = leagues
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let leagues = try container.decodeIfPresent([League].self, forKey: .leagues) {
            self.leagues = leagues
        }
    }
}
