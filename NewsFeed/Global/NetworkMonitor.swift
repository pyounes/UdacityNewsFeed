//
//  NetworkMonitor.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/18/21.
//

import UIKit
import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            print("isConnected: \(path.status)")
            
            if !(path.status == .satisfied) {
                DispatchQueue.main.async {
                    if let vc = UIApplication.topViewController() {
                        vc.showAlert(message: "The Internet connection appears to be offline ", title: "Error")
                    }
                }
            }
            
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
}
