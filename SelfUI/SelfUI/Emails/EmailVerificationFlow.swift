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
    @State private var email: String?
    var code: String = ""
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    
    public init(onFinish: ( (_ email: String, _ inView: EmailVerificationFlow) -> Void)? = nil, onEnteredCode: ((String, EmailVerificationFlow) -> Void)? = nil,  onResendCode: ((EmailVerificationFlow) -> Void)?
                = nil) {
        self.onFinish = onFinish
        self.onEnteredCode = onEnteredCode
        self.onResendCode = onResendCode
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            EnterEmailView { email in
                self.email = email
                path = [1]
            }.navigationDestination(for: Int.self) { selection in
                switch selection {
                    
                case 1:
                    EnterEmailCodeView(showAlert: $showAlert, onCode: { code in
                        onEnteredCode?(code, self)
                    }) {
                        // resend code
                        onResendCode?(self)
                    }
                    .onAppear {
                        if let email = email {
                            onFinish?(email, self)
                        }
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
