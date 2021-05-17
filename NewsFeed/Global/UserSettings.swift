//
//  UserSettings.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/16/21.
//

import Foundation

let userDefaults = UserDefaults.standard

var deleteOnExit: Bool {
    get {
        userDefaults.bool(forKey: "DeleteOnExit")
    }
    
    set {
        userDefaults.setValue(newValue, forKey: "DeleteOnExit")
    }
}
