//
//  League.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 10/11/2022.
//

import Foundation

// MARK: - League
public struct League: Codable {
    public private(set) var id: Int = 0
    public let name: String?
    public let sport: String?
    public let leagueAlternate: String?

    public init(id: Int, name: String? = nil, sport: String? = nil, leagueAlternate: String? = nil) {
        self.id = id
        self.name = name
        self.sport = sport
        self.leagueAlternate = leagueAlternate
    }

    enum CodingKeys: String, CodingKey {
        case id = "idLeague"
        case name = "strLeague"
        case sport = "strSport"
        case leagueAlternate = "strLeagueAlternate"
    }

    //MARK: - Codable
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let decodedValue = try container.decodeIfPresent(String.self, forKey: .id), let id = Int(decodedValue) {
            self.id = id
        }

        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.sport = try container.decodeIfPresent(String.self, forKey: .sport)
        self.leagueAlternate = try container.decodeIfPresent(String.self, forKey: .leagueAlternate)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode("\(id)", forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.sport, forKey: .sport)
        try container.encodeIfPresent(self.leagueAlternate, forKey: .leagueAlternate)
    }
}

extension League {
    public static var premierLeague: League {
        League(id: 4328, name: "English Premier League", sport: "Soccer", leagueAlternate: "Premier League")
    }

    public static var ligue1: League {
        League(id: 4334, name: "French Ligue 1", sport: "Soccer", leagueAlternate: "Ligue 1 Uber Eats")
    }
}
