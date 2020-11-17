import Foundation
import TinyNetworking

struct FootballData {
    let authToken: String
    let plan: Plan
    
    var authHeader: [String: String] {
        ["X-Auth-Token": FootballDataAPIConfiguration.authToken]
        }
    
    init(authToken: String, plan: Plan) {
        self.authToken = authToken
        self.plan = plan
    }
    
    func fetchCompetitions() -> Endpoint<Competitions> {
        return Endpoint<Competitions>(json: .get, url: url(withPath: "/v2/competitions", queryItems: [URLQueryItem(name: "plan", value: plan.rawValue)]))
    }
    
    func fetchSeasons(of competitionCode: String) -> Endpoint<Competition> {
        return Endpoint<Competition>(json: .get, url: url(withPath: "/v2/competitions/\(competitionCode)", queryItems: [URLQueryItem(name: "plan", value: plan.rawValue)]), headers: authHeader)
    }
    
    func fetchMatches(of competitionCode: String) -> Endpoint<Matches> {
        return Endpoint<Matches>(json: .get, url: url(withPath: "/v2/competitions/\(competitionCode)/matches"), headers: authHeader)
    }
    
    private func url(withPath path: String, queryItems: [URLQueryItem]? = nil) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.football-data.org"
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            fatalError("Couldn't build URL.")
        }
        
        return url
    }
}

extension FootballData {
    enum Plan: String, Codable {
        case tier1 = "TIER_ONE"
        case tier2 = "TIER_TWO"
        case tier3 = "TIER_THREE"
        case tier4 = "TIER_FOUR"
    }
}
