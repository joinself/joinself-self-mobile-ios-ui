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
    var onRecover: (() -> Void)?
    
    init(buttonTitle: String = "button_signup_now".localized, buttonColor: Color = .defaultPink, onGetStarted: ( () -> Void)? = nil, onRecover: (() -> Void)? = nil) {
        self.onGetStarted = onGetStarted
        self.buttonTitle = buttonTitle
        self.buttonColor = buttonColor
        self.onRecover = onRecover
    }
    
    public var body: some View {
        CustomNavigationView {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    onRecover?()
                } label: {
                    Text("button_recover_account".localized)
                        .modifier(ButtonTextStyle(color: Color.defaultDark))
                }
            }
        } content: {
            VStack (alignment: .leading, spacing: 30) {
                Text("welcome_title".localized)
                    .modifier(Heading1TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Text("welcome_message".localized)
                    .modifier(Body1TextStyle())
                Spacer()
            }
            
            ButtonView(title: buttonTitle, backgroundColor: buttonColor) {
                onGetStarted?()
            }
        }
    }
}

#Preview {
    WelcomeView()
}
