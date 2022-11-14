//
//  LeaguesViewModelTests.swift
//  FDJLeaguesTests
//
//  Created by Mickael Mas on 14/11/2022.
//

import XCTest
import FDJLeagueKit

final class LeaguesViewModelTests: XCTestCase {

    var viewModel = LeaguesViewModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test1OutOf2Empty() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let filteredTeams = [].filteredOneOutOfTwo()
        XCTAssertTrue(filteredTeams.isEmpty)
    }

    func test1OutOf2ForTeams() throws {
        let teams = Team.sampleTeams
        let filteredTeams = teams.filteredOneOutOfTwo()
        XCTAssertFalse(filteredTeams.isEmpty)
        XCTAssertTrue(teams.count == 5, "Teams count must be equal to 5")
        XCTAssertTrue(filteredTeams.count == 3, "Filtered teams count must be equal to 5")
        XCTAssertEqual(teams[0], filteredTeams[0], "The first element of each array must be equal")
        XCTAssertEqual(teams[2], filteredTeams[1], "The third element for the 1st array must be equal to the second element of the second array")
    }
}
