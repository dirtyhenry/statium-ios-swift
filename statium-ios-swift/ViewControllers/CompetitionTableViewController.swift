import UIKit
import TinyNetworking

final class CompetitionTableViewController: UITableViewController {
    var competitions: Competitions? = nil {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Competitions"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "competition")
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadCompetitions), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        loadCompetitions()
    }

    @IBAction private func loadCompetitions() {
        refreshControl?.beginRefreshing()
        URLSession.shared.load(FootballData.new().fetchCompetitions(), behavior: NetworkLoggingBehavior()) { result in
            self.competitions = try? result.get()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitions?.competitions.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let res = tableView.dequeueReusableCell(withIdentifier: "competition", for: indexPath)
        
        let name = competitions?.competitions[indexPath.row].name ?? "N/A"
        let flag = competitions?.competitions[indexPath.row].area.countryCode ?? "N/A"
        
        res.textLabel?.text = "\(flag) - \(name)"
        return res
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let competitionCode = competitions?.competitions[indexPath.row].code {
            let newVC = SeasonTableViewController(competitionCode: competitionCode)
            show(newVC, sender: self)
        }
    }
}

struct NetworkLoggingBehavior: RequestBehavior {
    func beforeSend(_ e: URLRequest) {
        debugPrint("Requesting \(String(describing: e.url))")
    }
    
    func onComplete(data: Data?, response: URLResponse?) {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        let dataAsString = data.map { String(data: $0, encoding: .utf8) }
        debugPrint("\(httpResponse.statusCode) \(String(describing: dataAsString))")
    }
}
