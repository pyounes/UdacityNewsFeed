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
    var feeds: Feeds?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News Feed"
                
        getNewsFeeds()
        
    }
    
    // Custom Methods
    private func getNewsFeeds() {
        NewsFeedServices.shared.getNews(by: .usa) { (result) in
            switch result {
            case .success(let response):
                self.feeds = response
                self.reloadTableView()
                break
            case .failure(let error):
                self.showAlert(message: error.localizedDescription, title: "Error")
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
        return feeds?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            if let article = feeds?.articles?[indexPath.row] {
                cell.textLabel?.text = article.title
                cell.imageView?.image = UIImage()
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
