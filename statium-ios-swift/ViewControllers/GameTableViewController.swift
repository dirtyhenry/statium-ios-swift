import UIKit

/// A view controller that displays a collection of games.
class GameTableViewController: UITableViewController {
    let competitionCode: String

    init(competitionCode: String) {
        self.competitionCode = competitionCode
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var games: GamesCollection? = nil {
        didSet {
            DispatchQueue.main.async {
                self.navigationItem.title = self.games?.name ?? ""
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }

    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "game")

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadGames), for: .valueChanged)
        tableView.refreshControl = refreshControl

        loadGames()
    }

    @IBAction private func loadGames() {
        refreshControl?.beginRefreshing()
        URLSession.shared.load(
            FootballData.new().fetchMatches(of: competitionCode),
                               behavior: NetworkLoggingBehavior()) { result in
            self.games = (try? result.get()).map { GamesCollection(games: $0) }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let games = games else { return 0 }
        
        let matchDay = games.sortedMatchDaysKeys[section]
        return games.gamesPerMatchDay[matchDay]!.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let games = games else { return 0 }

        return games.numberOfMatchDays
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let games = games else { fatalError() }

        let res = tableView.dequeueReusableCell(withIdentifier: "game", for: indexPath)

        let matchDay = games.sortedMatchDaysKeys[indexPath.section]
        let game = games.gamesPerMatchDay[matchDay]![indexPath.row]
        res.textLabel?.text = "\(game.homeTeam.name) - \(game.awayTeam.name)"
        return res
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (games?.sortedMatchDaysKeys[section]).map { "\($0)" }
    }
}
