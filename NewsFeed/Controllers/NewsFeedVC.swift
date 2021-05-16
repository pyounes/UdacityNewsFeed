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
    var dataController: DataController = (UIApplication.shared.delegate as! AppDelegate).dataController

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News Feed"
        
        feedsTableView.register(UINib(nibName: FeedCell.identifier, bundle: nil), forCellReuseIdentifier: FeedCell.identifier)
                
        getTopHeadlines()
        
    }
    
    // MARK: - Custom Methods
    
    /// Fetching TopHeadlines
    private func getTopHeadlines() {
        NewsFeedServices.shared.getTopHeadlinesBy(country: .usa) { [weak self] (result) in
            switch result {
            case .success(let articles):
                self?.vm = articles.compactMap {
                    FeedCellVM(title: $0.title!, url: $0.url!, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, imageData: nil)
                }
                self?.reloadTableView()
                break
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription, title: "Error")
                break
            }
        }
    }
    
    /// Reload TableView When data is fetched
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.feedsTableView.reloadData()
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
    }
    
    
    // Action to Download the Feed
    @objc func downloadFeed(sender: UIButton) {
        print("Downloading Feed at index: \(sender.tag)")
        addFeed(aFeed: vm[sender.tag])
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
