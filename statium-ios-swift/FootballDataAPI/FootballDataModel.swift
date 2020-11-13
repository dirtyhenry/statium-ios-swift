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
    let currentSeason: Season
    let numberOfAvailableSeasons: Int?
    let lastUpdated: String
    let seasons: [Season]?

    struct Area: Codable {
        let id: Int
        let name: String
        let countryCode: String?
        let ensignUrl: String?
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
}
