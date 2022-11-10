//
//  LeagueServices.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 10/11/2022.
//

import Foundation

protocol LeagueServices {
    func getAllLeagues() async throws -> [League]
}
