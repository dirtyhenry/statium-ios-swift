@testable import statium_ios_swift
@testable import TinyNetworking
import XCTest

class FootballDataAPITests: XCTestCase {
    func testFetchCompetitionsEndpoint() throws {
        let bundle = Bundle(for: Self.self)
        
        guard let jsonURL = bundle.url(forResource: "List_Competitions-1605183896583", withExtension: "json") else {
            fatalError("Resource URL could not be found.")
        }

        let jsonData = try Data(contentsOf: jsonURL)
        let endpoint = FootballData.new().fetchCompetitions()
        let result = try endpoint.parse(jsonData, nil).get()
        XCTAssertEqual(result.count, 12)
    }
    
    func testFetchSeasonsEndpoint() throws {
        let bundle = Bundle(for: Self.self)
        
        guard let jsonURL = bundle.url(forResource: "List_French_Ligue_1-1605217279524", withExtension: "json") else {
            fatalError("Resource URL could not be found.")
        }

        let jsonData = try Data(contentsOf: jsonURL)
        let endpoint = FootballData.new().fetchSeasons(of: "FL1")
        let result = try endpoint.parse(jsonData, nil).get()
        XCTAssertEqual(result.name, "Ligue 1")
    }
}
