import Foundation

struct GamesCollection {
    let name: String
    let gamesPerMatchDay: [Int: [Matches.Match]]
    
    var numberOfMatchDays: Int {
        return gamesPerMatchDay.keys.count
    }
    
    var sortedMatchDaysKeys: [Int] {
        return gamesPerMatchDay.keys.sorted()
    }
    
    init(games: Matches) {
        let season = games.matches.first!.season
        let yearRange = ModelFormatter.yearRange(
            from: ModelFormatter.dateFormatter.date(from: season.startDate)!,
            to: ModelFormatter.dateFormatter.date(from: season.endDate)!
        )
        
        name = "\(games.competition.area.name) \(games.competition.name) \(yearRange)"
        gamesPerMatchDay = Dictionary(grouping: games.matches) { $0.matchday }
    }
}

struct ModelFormatter {
    static let dateFormatter: ISO8601DateFormatter = {
        let res = ISO8601DateFormatter()
        res.formatOptions = .withFullDate
        return res
    }()

    static func yearRange(from firstBound: Date, to lastBound: Date, calendar: Calendar = .current) -> String {
        let sortedYears = Set([firstBound, lastBound].map({calendar.component(.year, from: $0)})).sorted()
        return sortedYears.map({ "\($0)" }).joined(separator: "-")
    }
}
