//
//  CreatingAccountView.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

struct CreatingAccountView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        VStack {
            // stepped progress view
            CustomProgressView(steps: [
                Step(title: "1", state: .done),
                Step(title: "2", state: .done),
                Step(title: "3", state: .done),
                Step(title: "4", state: .done),
                Step(title: "5", state: .active)
            ])
            
            Spacer(minLength: 50)
            VStack(alignment: .leading, spacing: 30) {
                Text("creating_account_title".localized)
                    .font(.defaultLargeTitle)
                    .foregroundColor(.black)
                
                Text("creating_account_description".localized)
                    .font(.defaultNormalTitle)
                    .foregroundColor(.black)
                
                HStack {
                    Spacer()
                    LoadingDotsView()
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
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
    CreatingAccountView()
}
