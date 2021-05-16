//
//  StoredNewsVC.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/13/21.
//

import UIKit
import CoreData

class StoredNewsVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var vm = [FeedCellVM]()
    var dataController: DataController = (UIApplication.shared.delegate as! AppDelegate).dataController

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stored News"
        view.backgroundColor = .systemBackground
        
        tableView.register(UINib(nibName: FeedCell.identifier, bundle: nil), forCellReuseIdentifier: FeedCell.identifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchArticles()
    }
    
    // MARK: - Customer Methods
    // fetch Saved Articles from Coredata
    fileprivate func fetchArticles() {
        let fetchRequest: NSFetchRequest<Feed> = Feed.fetchRequest()
        if let feeds = try? dataController.viewContext.fetch(fetchRequest) {
            self.vm = feeds.compactMap {
                FeedCellVM(title: $0.title!, url: $0.url!, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, imageData: $0.image)
            }
            self.tableView.reloadData()
        }
    }
    

}


// MARK: UITableView Delegate
extension StoredNewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell {
            cell.configureCell(vm: vm[indexPath.row], isDownloaded: true)
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
