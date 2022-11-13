//
//  LeagueServices.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 10/11/2022.
//

import Foundation

protocol APIServicesProtocol {
    func fetchAllLeagues() async throws -> [League] // API 1
    func fetchTeams(for league: League) async throws -> [Team] // API 2
    func fetchTeamDetail(for team: Team) async throws -> Team // API 3
}

enum APIServicesError: Error {
    case incorrectLeagueName
    case badURL
    case invalidLeagueName
    case invalidTeamName
    case tooManyTeams
    case noResults
}

class SportDBServicesAPI: APIServicesProtocol {
    static let shared = SportDBServicesAPI()

    func fetchAllLeagues() async throws -> [League] {
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/50130162/all_leagues.php") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let response = try JSONDecoder().decode(LeaguesResponse.self, from: data)

        return response.leagues
    }
    
    func fetchTeams(for league: League) async throws -> [Team] {

        guard let leagueName = league.name else {
            throw APIServicesError.invalidLeagueName
        }

        guard let leagueEncoded = leagueName.addingPercentEncoding(withAllowedCharacters: .alphanumerics), let url = URL(string: "https://www.thesportsdb.com/api/v1/json/50130162/search_all_teams.php?l=\(leagueEncoded)") else {

            throw APIServicesError.badURL
        }

        debugPrint("[getTeamsForLeague] : " + url.absoluteString)


        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(TeamResponse.self, from: data)

        if response.teams.isEmpty {
            throw APIServicesError.noResults
        }
        return response.teams.sorted { team1, team2 in
            guard let name1 = team1.name, let name2 = team2.name else {
                return false
            }
            return name1 > name2
        }
    }

    func fetchTeamDetail(for team: Team) async throws -> Team {

        guard let teamName = team.name else {
            throw APIServicesError.invalidTeamName
        }

        guard let teamNameEncoded = teamName.addingPercentEncoding(withAllowedCharacters: .alphanumerics), let url = URL(string: "https://www.thesportsdb.com/api/v1/json/50130162/searchteams.php?t=\(teamNameEncoded)") else {

            throw APIServicesError.badURL
        }

        debugPrint("[searchTeams] : " + url.absoluteString)

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(TeamResponse.self, from: data)

        switch response.teams.count {
        case 0:
            throw APIServicesError.noResults
        default:
            return response.teams[0] // This response may content more than one result (ex: Bournemouth)
        }
    }
}

class MockServicesAPI: APIServicesProtocol {

    static let shared = MockServicesAPI()

    func fetchAllLeagues() async throws -> [League] {
        return [League(id: 2, name: "Ligue 1", sport: "Football", leagueAlternate: "Uber Eats")]
    }

    func fetchTeams(for league: League) async throws -> [Team] {
        [Team(id: 1, name: "PSG", bannerImageUrl: nil, country: "France", league: "Ligue 1", descriptionEN: "LE PSG est le club de la capitale")]
    }

    func fetchTeamDetail(for team: Team) async throws -> Team {
        Team(id: 1, name: "PSG", bannerImageUrl: nil, country: "France", league: "Ligue 1", descriptionEN: "LE PSG est le club de la capitale")
    }
}
