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
                    PagingView { ok in
                        if ok {
                            path.append(1)
                        }
                    }
                    
                case 1:
                    ThankYouView {
                        print("joinself now.")
                        onFinish?(true)
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
