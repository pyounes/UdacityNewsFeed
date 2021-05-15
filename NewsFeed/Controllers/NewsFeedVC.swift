//
//  NewsFeedVC.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/13/21.
//

import UIKit

class NewsFeedVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var feedsTableView: UITableView!
    
    // Variables
    private var vm = [FeedCellVM]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News Feed"
        
        feedsTableView.register(UINib(nibName: FeedCell.identifier, bundle: nil), forCellReuseIdentifier: FeedCell.identifier)
                
        getNewsFeeds()
        
    }
    
    // Custom Methods
    private func getNewsFeeds() {
        NewsFeedServices.shared.getNews(by: .usa) { [weak self] (result) in
            switch result {
            case .success(let articles):
                self?.vm = articles.compactMap({
                    FeedCellVM(title: $0.title, subtitle: "", imageURL: URL(string: $0.urlToImage ?? ""))
                })
                
                self?.reloadTableView()
                break
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription, title: "Error")
                break
            }
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.feedsTableView.reloadData()
        }
    }
    

}


// MARK: UITableView Delegate
extension NewsFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell {
            cell.configureCell(with: vm[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
