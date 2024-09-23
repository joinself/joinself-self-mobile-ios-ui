//
//  EmailIntroView.swift
//  SelfUI
//
//  Created by Long Pham on 30/7/24.
//

import SwiftUI

struct EmailIntroView: View {
    
    @Environment(\.presentationMode) var presentationMode
    public init(onAccept: (() -> Void)? = nil) {
        self.onAccept = onAccept
    }
    
    var onAccept: (() -> Void)?
    
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
                Text("email_introduction_title".localized)
                    .font(.defaultTitle)
                    .foregroundColor(.textPrimary)
                    .minimumScaleFactor(0.7)
                Text("email_introduction_description".localized)
                    .font(.defaultBody)
                    .lineSpacing(1.14)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
            VStack(spacing: 12) {
                ButtonView(title: "button_verify_email".localized) {
                    onAccept?()
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
    EmailIntroView()
}
