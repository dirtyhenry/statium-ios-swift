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
        let endpoint = FootballData(authToken: "").fetchCompetitions()
        let result = try endpoint.parse(jsonData, nil).get()
        XCTAssertEqual(result.count, 12)
    }

    func testPerformanceExample() throws {
        let bundle = Bundle(for: Self.self)
        
        guard let jsonURL = bundle.url(forResource: "List_Competitions-1605183896583", withExtension: "json") else {
            fatalError("Resource URL could not be found.")
        }

        let jsonData = try Data(contentsOf: jsonURL)
        let endpoint = FootballData(authToken: "").fetchCompetitions()

        self.measure {
            let result = try! endpoint.parse(jsonData, nil).get()
        }
    }

}
