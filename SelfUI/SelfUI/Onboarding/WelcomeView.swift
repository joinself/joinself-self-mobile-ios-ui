//
//  WelcomeView.swift
//  SelfUI
//
//  Created by Long Pham on 25/7/24.
//

import SwiftUI

struct WelcomeView: View {
    var onGetStarted: (() -> Void)?
    let buttonTitle: String
    let buttonColor: Color
    
    init(buttonTitle: String = "button_signup_now".localized, buttonColor: Color = .defaultPink, onGetStarted: ( () -> Void)? = nil) {
        self.onGetStarted = onGetStarted
        self.buttonTitle = buttonTitle
        self.buttonColor = buttonColor
    }
    
    public var body: some View {
        VStack {
            Spacer(minLength: 100)
            VStack(alignment: .leading, spacing: 30) {
                Text("welcome_title".localized)
                    .font(.defaultLargeTitle)
                    .foregroundColor(.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                Text("welcome_message".localized)
                    .font(.defaultBody)
                    .lineSpacing(1.14)
                    .foregroundColor(.textPrimary)
                Spacer()
            }.padding()
            
            VStack(spacing: 15) {
                ButtonView(title: buttonTitle, backgroundColor: buttonColor) {
                    onGetStarted?()
                }
                
                BrandView(isDarked: true)
            }.padding()
        }
        .background(Color.backgroundPrimary)
    }
}

#Preview {
    WelcomeView()
}
