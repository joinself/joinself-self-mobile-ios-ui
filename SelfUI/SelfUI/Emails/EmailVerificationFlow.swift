//
//  EmailVerificationFlow.swift
//  SelfUI
//
//  Created by Long Pham on 30/7/24.
//

import SwiftUI

public struct EmailVerificationFlow: View {
    @State private var path = [Int]()
    var onFinish: ((String) -> Void)?
    
    public init(onFinish: ( (_ email: String) -> Void)? = nil) {
        self.onFinish = onFinish
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            EmailIntroView {
                path = [0]
            }.navigationDestination(for: Int.self) { selection in
                switch selection {
                case 0:
                    EnterEmailView { email in
                        print("Email: \(email)")
                        onFinish?(email)
                    }
                    
                case 1:
                    EnterEmailCodeView (onCode: { code in
                        
                    }) {
                        // resend code
                    }
                    
                default:
                    Text("0")
                }
            }
        }
    }
}

#Preview {
    EmailVerificationFlow()
}
