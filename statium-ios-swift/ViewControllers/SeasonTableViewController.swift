import UIKit

final class SeasonTableViewController: UITableViewController {
    let competitionCode: String
    
    init(competitionCode: String) {
        self.competitionCode = competitionCode
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var competition: Competition? = nil {
        didSet {
            DispatchQueue.main.async {
                self.navigationItem.title = self.competition?.name
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }

    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "season")

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadCompetition), for: .valueChanged)
        tableView.refreshControl = refreshControl

        loadCompetition()
    }

    @IBAction private func loadCompetition() {
        refreshControl?.beginRefreshing()
        URLSession.shared.load(
            FootballData.new().fetchSeasons(of: competitionCode),
                               behavior: NetworkLoggingBehavior()) { result in
            self.competition = try? result.get()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competition?.seasons?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let res = tableView.dequeueReusableCell(withIdentifier: "season", for: indexPath)

        let season = competition?.seasons?[indexPath.row]
        
        let startDate = season?.startDate ?? "N/A"
        let endDate = season?.endDate ?? "N/A"
        let winner = season?.winner?.name

        res.textLabel?.text = "\(startDate) - \(endDate) \(String(describing: winner))"
        return res
    }
}
