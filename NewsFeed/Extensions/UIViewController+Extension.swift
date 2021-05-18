//
//  UIViewController+Extension.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/14/21.
//

import UIKit


extension UIViewController {
    
    // MARK: Show alerts
    func showAlert(message: String, title: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertVC, animated: true)
        }
    }
    
    
    /// Push View Controller
    // MARK: Push LocationVC
    func pushToArticleDetailVC(url: URL) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: ArticleDetailVC.identifier) as ArticleDetailVC
        vc.url = url
        navigationController?.pushViewController(vc, animated: true)
    }
}
