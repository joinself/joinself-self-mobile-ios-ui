//
//  ExampleApp.swift
//  Example
//
//  Created by Long Pham on 14/5/24.
//

import SwiftUI
import SelfUI

@main
struct ExampleApp: App {
    
    init() {
        print("App is launching.")
        SelfUISdk.shared.initialize(customization: false)
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
