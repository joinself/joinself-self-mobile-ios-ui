//
//  EmailVerificationFailedView.swift
//  SelfUI
//
//  Created by Long Pham on 2/8/24.
//

import SwiftUI

public struct EmailVerificationFailedView: View {
    
    @Environment(\.presentationMode) var presentationMode
    public init(completion: (() -> Void)? = nil) {
        self.completion = completion
    }
    
    var completion: (() -> Void)?
    
    public var body: some View {
        BaseProgressView (totalSteps: 6, activeStep: 4, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text("email_verification_failed_title".localized)
                    .modifier(Heading3TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Spacer()
            }
            
            Spacer()
            ButtonView(title: "button_next".localized) {
                completion?()
            }
        })
    }
}

#Preview {
    EmailVerificationFailedView()
}
