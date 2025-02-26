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
    var onRecover: (() -> Void)?
    
    public init(onFinish: ( (Bool) -> Void)? = nil, onRecover: (() -> Void)? = nil) {
        self.onFinish = onFinish
        self.onRecover = onRecover
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            WelcomeView(buttonTitle: "button_get_started".localized, buttonColor: .defaultGreen, onGetStarted:  {
                path = [0]
            }, onRecover: {
                onRecover?()
            })
            .navigationDestination(for: Int.self) { selection in
                switch selection {
                case 0:
                    ThankYouView (buttonColor: .defaultGreen) {
                        print("joinself now.")
//                        path.append(1)
                        onFinish?(true)
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
