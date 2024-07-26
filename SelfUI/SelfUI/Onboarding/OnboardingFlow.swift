//
//  OnboardingFlow.swift
//  SelfUI
//
//  Created by Long Pham on 26/7/24.
//

import SwiftUI

public struct OnboardingFlow: View {
    @State private var getStarted = false
    public init() {
    }
    
    public var body: some View {
        NavigationStack {
            WelcomeView {
                getStarted = true
            }.navigationDestination(isPresented: $getStarted) {
                PagingView()
            }
        }
    }
}

#Preview {
    OnboardingFlow()
}
