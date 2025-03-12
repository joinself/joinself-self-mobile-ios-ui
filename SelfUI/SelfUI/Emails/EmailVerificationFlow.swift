//
//  EmailVerificationFlow.swift
//  SelfUI
//
//  Created by Long Pham on 30/7/24.
//

import SwiftUI
import Combine

public class EmailFlowViewModel: ObservableObject {
    @Published public var isVerified: Bool = false
    public init(isVerified: Bool) {
        self.isVerified = isVerified
    }
}


public struct EmailVerificationFlow: View {
    @State private var path = [Int]()
    var onEmail: ((String) -> Void)?
    var onEnteredCode: ((String, EmailVerificationFlow) -> Void)?
    var onResendCode: ((EmailVerificationFlow) -> Void)?
    @State private var email: String?
    var code: String = ""
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: EmailFlowViewModel
    
    public init(viewModel: EmailFlowViewModel,
                onEmail: ((String) -> Void)? = nil, onEnteredCode: ((String, EmailVerificationFlow) -> Void)? = nil,  onResendCode: ((EmailVerificationFlow) -> Void)?
                = nil) {
        self.viewModel = viewModel
        self.onEmail = onEmail
        self.onEnteredCode = onEnteredCode
        self.onResendCode = onResendCode
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            EnterEmailView { email in
                self.email = email
                onEmail?(email)
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
                    
                case 2:
                    EmailVerificationFailedView {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                default:
                    Text("0")
                }
            }
        }
        .onChange(of: viewModel.isVerified) { newValue in
            print("Email is verified: \(newValue)")
            presentationMode.wrappedValue.dismiss()
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
    EmailVerificationFlow(viewModel: EmailFlowViewModel.init(isVerified: false))
}
