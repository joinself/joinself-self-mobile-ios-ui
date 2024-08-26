//
//  DevOnboardingFlow.swift
//  SelfUI
//
//  Created by Long Pham on 22/8/24.
//

import SwiftUI

public struct DevOnboardingFlow: View {
    @State private var path = [Int]()
    var onFinish: ((Bool) -> Void)?
    
    public init(onFinish: ( (Bool) -> Void)? = nil) {
        self.onFinish = onFinish
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            WelcomeView(buttonTitle: "I’m going to develop with Self".localized, buttonColor: .defaultGreen) {
                path = [0]
            }
            .navigationDestination(for: Int.self) { selection in
                switch selection {
                case 0:
                    ThankYouView (buttonColor: .defaultGreen) {
                        print("joinself now.")
                        path.append(1)
                    }
                    
                case 1:
                    OnboardingSurveyView(buttonColor: .defaultOrange, onNext: {
                        print("Next")
                        onFinish?(true)
                    }) {
                        print("Back to root: \(path)")
                        path = []
                    }
                    
                case 2: // liveness
                    LivenessFlow()
                    
                default:
                    Text("0")
                }
            }
        }
    }
}

#Preview {
    DevOnboardingFlow()
}
