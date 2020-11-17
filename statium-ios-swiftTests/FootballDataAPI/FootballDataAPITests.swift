@testable import statium_ios_swift
@testable import TinyNetworking
import XCTest

class FootballDataAPITests: XCTestCase {
    lazy var bundle = Bundle(for: Self.self)
    
    func testFetchCompetitionsEndpoint() throws {
        let jsonData = try bundle.jsonData(forResource: "List_Competitions-1605183896583")
        let endpoint = FootballData.new().fetchCompetitions()
        let result = try endpoint.parse(jsonData, nil).get()
        XCTAssertEqual(result.count, 12)
    }
    
    func testFetchSeasonsEndpoint() throws {
        let jsonData = try bundle.jsonData(forResource: "List_French_Ligue_1-1605217279524")
        let endpoint = FootballData.new().fetchSeasons(of: "FL1")
        let result = try endpoint.parse(jsonData, nil).get()
        XCTAssertEqual(result.name, "Ligue 1")
    }
    
    func testFetchMatchesEndpoint() throws {
        let jsonData = try bundle.jsonData(forResource: "Ligue_1_2020-2021_Calendar-1605615579666")
        let endpoint = FootballData.new().fetchMatches(of: "FL1")
        let result = try endpoint.parse(jsonData, nil).get()
        XCTAssertEqual(result.count, 380)
    }
}
