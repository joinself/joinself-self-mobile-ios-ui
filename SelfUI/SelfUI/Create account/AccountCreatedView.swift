//
//  AccountCreatedView.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

struct AccountCreatedView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    public init(callback: (() -> Void)? = nil) {
        self.callback = callback
    }
    
    var callback: (() -> Void)?
    
    public var body: some View {
        VStack {
            // stepped progress view
            CustomProgressView(steps: [
                Step(title: "1", state: .done),
                Step(title: "2", state: .done),
                Step(title: "3", state: .done),
                Step(title: "4", state: .done),
                Step(title: "5", state: .done)
            ])
            
            Spacer(minLength: 50)
            VStack(alignment: .leading, spacing: 30) {
                Text("account_created_title".localized)
                    .font(.defaultLargeTitle)
                    .foregroundColor(.black)
                
                Text("account_created_description".localized)
                    .font(.defaultBody)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
            VStack(spacing: 12) {
                ButtonView(title: "button_turn_on_notifications".localized) {
                    callback?()
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
                    NavBackButton()
                }
            }
        }
    }
}

#Preview {
    AccountCreatedView()
}
