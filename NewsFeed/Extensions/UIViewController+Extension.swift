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
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alertVC, animated: true)
        }
        
    }
}
