//
//  LeaguesViewModel.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 10/11/2022.
//

import Foundation
import Combine
import FDJLeagueKit


class LeaguesViewModel: ObservableObject {

    private var leagues: [League] = []
    @Published var filteredLeagues: [League] = []
    @Published private(set) var teams: [Team] = []
    @Published var isLoading = false

    var searchText: String = "" {
        didSet {
            searchTextPublisher.send(searchText)
        }
    }
    private(set) var searchTextPublisher = PassthroughSubject<String, Never>()
    private(set) var loadingPublisher = PassthroughSubject<Bool, Never>()

    init() {
        Task {
            leagues = try await fetchAllLeagues()
            filteredLeagues = leagues
        }
    }

    // MARK: - Helpers

    func filterLeaguesForSearchText(_ searchText: String) -> [League] {
        return leagues.filter { (league: League) -> Bool in
            guard let leagueName = league.name else { return false }

            return leagueName.lowercased().contains(searchText.lowercased())
        }
    }

    func resetFilters() {
        filteredLeagues.removeAll()
    }
}

extension LeaguesViewModel: APIServicesProtocol {

    public func fetchAllLeagues() async throws -> [League] {
        return try await SportDBServicesAPI.shared.fetchAllLeagues()
    }

    public func fetchTeams(for league: League) async throws -> [Team] {
        let teams = try await SportDBServicesAPI.shared.fetchTeams(for: league)
        self.teams = teams.filteredOneOutOfTwo()
        return self.teams
    }

    public func fetchTeamDetail(for team: Team) async throws -> Team {
        return try await SportDBServicesAPI.shared.fetchTeamDetail(for: team)
    }
}

