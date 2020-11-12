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
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.football-data.org"
        components.path = "/v2/competitions"
        components.queryItems = [URLQueryItem(name: "plan", value: plan.rawValue)]

        guard let url = components.url else {
            fatalError("Couldn't build URL")
        }

        return Endpoint<Competitions>(json: .get, url: url)
    }
    
    func fetchSeasons(of competitionCode: String) -> Endpoint<Competition> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.football-data.org"
        components.path = "/v2/competitions/\(competitionCode)"

        guard let url = components.url else {
            fatalError("Couldn't build URL")
        }

        return Endpoint<Competition>(json: .get, url: url, headers: authHeader)
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
