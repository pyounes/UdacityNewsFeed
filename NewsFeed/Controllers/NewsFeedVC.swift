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
    var vm = [FeedCellVM]()
    private let searchVC = UISearchController(searchResultsController: nil)
    var dataController: DataController = (UIApplication.shared.delegate as! AppDelegate).dataController

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News Feed"
        
        feedsTableView.register(UINib(nibName: FeedCell.identifier, bundle: nil), forCellReuseIdentifier: FeedCell.identifier)
        createSearchBar()
        getTopHeadlines()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !NetworkMonitor.shared.isConnected {self.showAlert(message: "The Internet connection appears to be offline ", title: "Error") }
    }
    
    // MARK: - Custom Methods
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    private func handleResult(result: Result<[Article], Error>) {
        
        switch result {
        case .success(let articles):
            self.vm.removeAll()
            self.vm = articles.compactMap {
                FeedCellVM(title: $0.title!, url: $0.url!, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt)
            }
            self.reloadTableView()
            break
        case .failure(let error):
            if !NetworkMonitor.shared.isConnected {self.showAlert(message: "The Internet connection appears to be offline ", title: "Error") } else {
                self.showAlert(message: error.localizedDescription, title: "Error")
            }
            break
        }
    }
    
    
    /// Fetching TopHeadlines
    private func getTopHeadlines() {
        NewsFeedServices.shared.getTopHeadlinesBy(country: .usa) { [weak self] (result) in
            guard let strong = self else { return }
            strong.handleResult(result: result)
        }
    }
    
    /// Fetching TopHeadlines with query
    private func getTopHeadlinesByQuery(txt: String) {
        NewsFeedServices.shared.getTopHeadlinesBy(query: txt) { [weak self] (result) in
            guard let strong = self else { return }
            strong.handleResult(result: result)
        }
    }
    
    /// Reload TableView When data is fetched
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.feedsTableView.reloadData()
            self.searchVC.dismiss(animated: true, completion: nil)
        }
    }
    
    // add Feed to CoreData
    private func addFeed(aFeed: FeedCellVM) {
        let feed = Feed(context: self.dataController.viewContext)
        feed.title      = aFeed.title
        feed.image      = aFeed.imageData
        feed.url        = aFeed.url
        feed.urlToImage = aFeed.urlToImage
     
        dataController.save()
        self.showAlert(message: "News Feed is Successfully Saved!", title: "Saved")
        
    }
    
    
    // Action to Download the Feed
    @objc func downloadFeed(sender: UIButton) {
        print("Downloading Feed at index: \(sender.tag)")
        addFeed(aFeed: vm[sender.tag])
        vm[sender.tag].isDownloaded = true
        self.feedsTableView.reloadData()
    }

}

// MARK: - SearchBar Delegate
extension NewsFeedVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        getTopHeadlinesByQuery(txt: text)
    }
}


// MARK: UITableView Delegate
extension NewsFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell {
            cell.configureCell(vm: vm[indexPath.row])
            cell.btnDownload.tag = indexPath.row
            cell.btnDownload.addTarget(self, action: #selector(downloadFeed(sender:)), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: vm[indexPath.row].url) {
            self.pushToArticleDetailVC(url: url)
        }
    }
    
}
