import Foundation

struct Competitions: Codable {
    let count: Int
    let filters: Filters
    let competitions: [Competition]
    
    struct Filters: Codable {
        let plan: String
    }
}

struct Competition: Codable {
    let id: Int
    let area: Area
    let name: String
    let code: String
    let emblemUrl: String?
    let plan: String
    let currentSeason: Season?
    let numberOfAvailableSeasons: Int?
    let lastUpdated: String
    let seasons: [Season]?

    struct Area: Codable {
        let id: Int
        let name: String
        let countryCode: String?
        let ensignUrl: String?
    }
}

struct Matches: Codable {
    let count: Int
    let competition: Competition
    let matches: [Match]
    
    struct Match: Codable {
        let id: Int
        let season: Season
        let utcDate: String
        let status: String
        let matchday: Int
        let stage: String
        let group: String
        let lastUpdated: String
        let score: Score
        let homeTeam: Team
        let awayTeam: Team
        let referees: [Referee]
        
        struct Score: Codable {
            let winner: String?
            let duration: String
            let fullTime: ScoreResult
            let halfTime: ScoreResult
            let extraTime: ScoreResult
            let penalties: ScoreResult
            
            struct ScoreResult: Codable {
                let homeTeam: Int?
                let awayTeam: Int?
            }
        }
        
        struct Team: Codable {
            let id: Int
            let name: String
        }
        
        struct Referee: Codable {
            let id: Int
            let name: String?
            let nationality: String?
        }
    }
}

struct Season: Codable {
    let id: Int
    let startDate: String
    let endDate: String
    let currentMatchDay: Int?
    let winner: Winner?
}

struct Winner: Codable {
    let id: Int
    let name: String
    let shortName: String
    let tla: String
    let crestUrl: String
}
