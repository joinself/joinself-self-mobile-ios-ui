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
    var body: some Scene {
        WindowGroup {
            OnboardingFlow().onAppear(perform: {
                FontLoader.loadFont()
            })
        }
    }
}
