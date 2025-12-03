//
//  RegistrationErrorView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct RegistrationErrorView: View {
    var onAction: (() -> Void)?
    let errorMessage: String?
    
    public init(errorMessage: String? = nil, onAction: (() -> Void)? = nil) {
        self.onAction = onAction
        self.errorMessage = errorMessage
    }
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 6, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text("Registration failed.")
                    .modifier(Heading1TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .modifier(Body1TextStyle())
                }
                
                Spacer()
                ButtonView(title: "button_try_again".localized) {
                    onAction?()
                }
            }
        })
    }
}

#Preview {
    RegistrationErrorView(errorMessage: "Error message.")
}
