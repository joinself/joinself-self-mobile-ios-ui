//
//  WelcomeView.swift
//  SelfUI
//
//  Created by Long Pham on 25/7/24.
//

import SwiftUI

struct WelcomeView: View {
    var onGetStarted: (() -> Void)?
    init(onGetStarted: (() -> Void)? = nil) {
        self.onGetStarted = onGetStarted
    }
    
    public var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Set the background
            VStack(alignment: .center, spacing: 0) {
                Spacer(minLength: 100)
                VStack(alignment: .leading, spacing: 30) {
                    Text("welcome_title".localized)
                        .font(.system(size: 64).weight(.bold))
                        .foregroundColor(.black)
                    Text("welcome_message".localized)
                        .font(Font.custom("Barlow-Regular", size: 17).weight(.regular))
                      .lineSpacing(1.14)
                      .foregroundColor(.black)
                    Spacer()
                }
                .padding(EdgeInsets(top: 50, leading: 24, bottom: 10, trailing: 24))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
                VStack(spacing: 12) {
                    ButtonView(title: "button_signup_now".localized, backgroundColor: .defaultPink) {
                        onGetStarted?()
                    }
                    
                    BrandView(isDarked: true)
                }.padding()
            }
            .padding()
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    WelcomeView()
}
