//
//  StoredNewsVC.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/13/21.
//

import UIKit
import CoreData

class StoredNewsVC: UIViewController {
    
    // Variables
    var dataController: DataController!
    var feeds: [Feed] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stored News"
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Customer Methods
    // fetch Saved Articles from Coredata
    fileprivate func fetchArticles() {
        let fetchRequest: NSFetchRequest<Feed> = Feed.fetchRequest()
        if let result = try? dataController.viewContext.fetch(fetchRequest) {
            feeds = result
        }
    }
    

}
