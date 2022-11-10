//
//  Team.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 10/11/2022.
//

import Foundation

// MARK: - Team
public struct Team: Codable {

    public private(set) var id: Int = 0
    public let name: String?
    public let bannerImageUrl: URL?
    public let country: String?
    public let league: String?
    public let descriptionFr: String?

    enum CodingKeys: String, CodingKey {
        case id = "idTeam"
        case name = "strTeam"
        case bannerImageUrl = "strTeamBanner"
        case country = "strCountry"
        case league = "strLeague"
        case descriptionFr = "strDescriptionFR"
    }

    public init(id: Int, name: String? = nil, bannerImageUrl: URL? = nil, country: String? = nil, league: String? = nil, descriptionFr: String? = nil) {
        self.id = id
        self.name = name
        self.bannerImageUrl = bannerImageUrl
        self.country = country
        self.league = league
        self.descriptionFr = descriptionFr
    }

    //MARK: - Codable

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let decodedValue = try container.decodeIfPresent(String.self, forKey: .id), let id = Int(decodedValue) {
            self.id = id
        }

        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.bannerImageUrl = try container.decodeIfPresent(URL.self, forKey: .bannerImageUrl)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.league = try container.decodeIfPresent(String.self, forKey: .league)
        self.descriptionFr = try container.decodeIfPresent(String.self, forKey: .descriptionFr)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode("\(self.id)", forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.bannerImageUrl, forKey: .bannerImageUrl)
        try container.encodeIfPresent(self.country, forKey: .country)
        try container.encodeIfPresent(self.league, forKey: .league)
        try container.encodeIfPresent(self.descriptionFr, forKey: .descriptionFr)
    }
}
