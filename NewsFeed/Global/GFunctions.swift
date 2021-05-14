//
//  GFunctions.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/14/21.
//

import Foundation
import UIKit


class GFunctions: NSObject {
    
    static let shared : GFunctions = GFunctions()

    
    private let ai = UIActivityIndicatorView(style: .large)
    private let view: UIView = UIView(frame: UIApplication.topViewController()!.view.bounds)
    
    func addLoader() {
        removeLoader()

        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            self.ai.center = self.view.center
            self.ai.startAnimating()
            self.view.addSubview(self.ai)
            UIApplication.topViewController()!.view.addSubview(self.view)
        }
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            self.view.removeFromSuperview()
            self.ai.stopAnimating()
        }
     }
    
}
