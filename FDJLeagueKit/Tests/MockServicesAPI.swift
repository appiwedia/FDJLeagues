//
//  File.swift
//  
//
//  Created by Mickael Mas on 14/11/2022.
//

import Foundation
import FDJLeagueKit

public class MockServicesAPI: APIServicesProtocol {

    static let shared = MockServicesAPI()

    public func fetchAllLeagues() async throws -> [League] {
        return [League(id: 2, name: "Ligue 1", sport: "Football", leagueAlternate: "Uber Eats")]
    }

    public func fetchTeams(for league: League) async throws -> [Team] {
        [Team(id: 1, name: "PSG", bannerImageUrl: nil, country: "France", league: "Ligue 1", descriptionEN: "LE PSG est le club de la capitale")]
    }

    public func fetchTeamDetail(for team: Team) async throws -> Team {
        Team(id: 1, name: "PSG", bannerImageUrl: nil, country: "France", league: "Ligue 1", descriptionEN: "LE PSG est le club de la capitale")
    }
}
