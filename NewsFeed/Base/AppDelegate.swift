//
//  AppDelegate.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/13/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let dataController = DataController(modelName: "NewsFeed")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Load Persistent Data Controller
        dataController.load()
        
        NetworkMonitor.shared.startMonitoring()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if deleteOnExit { dataController.deleteSavedFeed() }
    }
    
}
