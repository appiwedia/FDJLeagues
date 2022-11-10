//
//  TeamServices.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 10/11/2022.
//

import Foundation

protocol TeamServices {
    func getTeams(for league: String) async throws -> [Team]
    func searchTeams(_ terms: String) async throws -> [Team]
}
