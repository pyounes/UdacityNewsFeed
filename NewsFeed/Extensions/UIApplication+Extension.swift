//
//  UIApplication+Extension.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/14/21.
//

import UIKit

extension UIApplication {

    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        } else if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        } else if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        } else if let searchController = controller as? UISearchController {
           return searchController.presentingViewController
        }
        
        return controller
    }
}

