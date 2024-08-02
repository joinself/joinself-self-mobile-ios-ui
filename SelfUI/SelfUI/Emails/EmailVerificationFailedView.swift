//
//  EmailVerificationFailedView.swift
//  SelfUI
//
//  Created by Long Pham on 2/8/24.
//

import SwiftUI

struct EmailVerificationFailedView: View {
    
    @Environment(\.presentationMode) var presentationMode
    public init(completion: (() -> Void)? = nil) {
        self.completion = completion
    }
    
    var completion: (() -> Void)?
    
    public var body: some View {
        VStack {
            // stepped progress view
            CustomProgressView(steps: [
                Step(title: "1", state: .done),
                Step(title: "2", state: .done),
                Step(title: "3", state: .done),
                Step(title: "4", state: .active),
                Step(title: "5", state: .inactive)
            ])
            
            Spacer(minLength: 50)
            VStack(alignment: .leading, spacing: 30) {
                Text("email_verification_failed_title".localized)
                    .font(.defaultTitle)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
            VStack(spacing: 12) {
                ButtonView(title: "button_next".localized) {
                    completion?()
                }
                
                BrandView(isDarked: true)
            }.padding()
        }
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image("ic_back_dark", bundle: mainBundle)
                    }
                }
            }
        }
    }
}

#Preview {
    EmailVerificationFailedView()
}
