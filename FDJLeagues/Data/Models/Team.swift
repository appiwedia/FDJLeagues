//
//  Team.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 10/11/2022.
//

import Foundation

// MARK: - Team
public struct Team: Codable, Hashable {

    public private(set) var id: Int = 0
    public let name: String?
    public private(set) var badgeImageUrl: URL?
    public private(set) var bannerImageUrl: URL?
    public let country: String?
    public let league: String?
    public let descriptionEN: String?

    enum CodingKeys: String, CodingKey {
        case id = "idTeam"
        case name = "strTeam"
        case badgeImageUrl = "strTeamBadge"
        case bannerImageUrl = "strTeamBanner"
        case country = "strCountry"
        case league = "strLeague"
        case descriptionEN = "strDescriptionEN"
    }

    public init(id: Int, name: String? = nil, badgeImageUrl: URL? = nil, bannerImageUrl: URL? = nil, country: String? = nil, league: String? = nil, descriptionEN: String? = nil) {
        self.id = id
        self.name = name
        self.badgeImageUrl = badgeImageUrl
        self.bannerImageUrl = bannerImageUrl
        self.country = country
        self.league = league
        self.descriptionEN = descriptionEN
    }

    //MARK: - Codable

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let decodedValue = try container.decodeIfPresent(String.self, forKey: .id), let id = Int(decodedValue) {
            self.id = id
        }

        self.name = try container.decodeIfPresent(String.self, forKey: .name)

        if let value = try? container.decodeIfPresent(String.self, forKey: .badgeImageUrl) {
            self.badgeImageUrl = URL(string: value)
        }

        if let value = try? container.decodeIfPresent(String.self, forKey: .bannerImageUrl) {
            self.bannerImageUrl = URL(string: value)
        }
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.league = try container.decodeIfPresent(String.self, forKey: .league)
        self.descriptionEN = try container.decodeIfPresent(String.self, forKey: .descriptionEN)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode("\(self.id)", forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.badgeImageUrl, forKey: .badgeImageUrl)
        try container.encodeIfPresent(self.bannerImageUrl, forKey: .bannerImageUrl)
        try container.encodeIfPresent(self.country, forKey: .country)
        try container.encodeIfPresent(self.league, forKey: .league)
        try container.encodeIfPresent(self.descriptionEN, forKey: .descriptionEN)
    }
}
