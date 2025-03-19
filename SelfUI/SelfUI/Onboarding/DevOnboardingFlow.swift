//
//  DevOnboardingFlow.swift
//  SelfUI
//
//  Created by Long Pham on 22/8/24.
//

import SwiftUI

public struct DevOnboardingFlow: View {
    @State private var path = [Int]()
    private let onStart: (() -> Void)?
    private let onFinish: (() -> Void)?
    private let onRecover: (() -> Void)?
    private let onEnterName: ((String) -> Void)?
    
    public init(onStart: ( () -> Void)? = nil,
                onEnterName: ( (String) -> Void)? = nil,
                onFinish: (() -> Void)? = nil,
                onRecover: (() -> Void)? = nil) {
        self.onEnterName = onEnterName
        self.onStart = onStart
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
                        onStart?()
//                        path = [1]
                    }
                    
                case 1:
                    CreateAccountFlow { name in
                        onEnterName?(name)
                    } onFinish: { success in
                        onFinish?()
                    }
                    
                case 2:
                    OnboardingSurveyView(buttonColor: .defaultOrange, onNext: {
                        onStart?()
                    }) {
                        path = []
                    }
                    
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
