//
//  OnboardingSurveyView.swift
//  SelfUI
//
//  Created by Long Pham on 23/8/24.
//

import SwiftUI

struct OnboardingSurveyView: View {
    @State private var isOn = false
    @Environment(\.presentationMode) var presentationMode
    
    let buttonColor: Color
    
    var onGetStarted: (() -> Void)?
    init(buttonColor: Color = .defaultOrange, onGetStarted: (() -> Void)? = nil) {
        self.buttonColor = buttonColor
        self.onGetStarted = onGetStarted
    }
    
    public var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Set the background
            VStack(alignment: .leading, spacing: 0) {
                Spacer(minLength: 100)
                VStack(alignment: .leading, spacing: 0) {
                    Text("Thanks. How will you be using Self?".localized)
                        .font(.defaultLargeTitle)
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding()
                    Spacer()
                }.padding()
                Spacer()
                VStack(spacing: 12) {
                    VStack (spacing: 0){
                        
                        
                    }.padding(0)
                    
                    
                    ButtonView(title: "I’m using the Self Sandbox".localized, backgroundColor: self.buttonColor) {
                        onGetStarted?()
                    }
                    
                    BrandView(isDarked: true)
                }.padding()
            }
            .padding()
            .ignoresSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    NavBackButton()
                }
            }
        }
    }
}

#Preview {
    OnboardingSurveyView(buttonColor: .defaultOrange)
}
