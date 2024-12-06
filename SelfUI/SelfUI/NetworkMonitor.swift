//
//  NetworkMonitor.swift
//  DeveloperApp
//
//  Created by Long Pham on 27/9/24.
//

import Network
import SwiftUI

class NetworkMonitor: ObservableObject {
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global(qos: .background)
    
    @Published var isConnected: Bool = true
    
    init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
                print("Network status: \(self.isConnected)")
            }
        }
        monitor.start(queue: queue)
    }
}

