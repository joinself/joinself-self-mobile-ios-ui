//
//  EmailVerificationFlow.swift
//  SelfUI
//
//  Created by Long Pham on 30/7/24.
//

import SwiftUI

public struct EmailVerificationFlow: View {
    @State private var path = [Int]()
    var onFinish: ((String, EmailVerificationFlow) -> Void)?
    var onEnteredCode: ((String, EmailVerificationFlow) -> Void)?
    var onResendCode: ((EmailVerificationFlow) -> Void)?
    var email: String = ""
    var code: String = ""
    @State private var showAlert = false
    @State private var pinCode: [String] = Array(repeating: "", count: 6)
    @Environment(\.presentationMode) var presentationMode
    
    
    public init(onFinish: ( (_ email: String, _ inView: EmailVerificationFlow) -> Void)? = nil, onEnteredCode: ((String, EmailVerificationFlow) -> Void)? = nil,  onResendCode: ((EmailVerificationFlow) -> Void)?
 = nil) {
        self.onFinish = onFinish
        self.onEnteredCode = onEnteredCode
        self.onResendCode = onResendCode
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
                        onFinish?(email, self)
                    }
                    
                case 1:
                    EnterEmailCodeView(showAlert: $showAlert, onCode: { code in
                        onEnteredCode?(code, self)
                    }) {
                        // resend code
                        onResendCode?(self)
                    }
                    
                case 2:
                    EmailVerificationFailedView {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                default:
                    Text("0")
                }
            }
        }
    }
    
    public func showCodeView() {
        path.append(1)
    }
    
    public func showVerificationFailed() {
        path.append(2)
    }
    
    public func showRemainingAttemp(remaingNumber: Int) {
        showAlert = true
        print("showRemainingAttemp: \(remaingNumber)")
    }
}

#Preview {
    EmailVerificationFlow()
}
