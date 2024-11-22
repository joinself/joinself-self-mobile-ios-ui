//
//  DocumentVerifyingView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct DocumentVerifyingView: View {
    
    public init(onBack: (() -> Void)? = nil, onNext: (() -> Void)? = nil) {
        self.onBack = onBack
        self.onNext = onNext
    }
    
    var onNext: (() -> Void)?
    var onBack: (() -> Void)?
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            CustomProgressView(steps: [
                Step(title: "1", state: .done),
                Step(title: "2", state: .done),
                Step(title: "3", state: .done),
                Step(title: "4", state: .done),
                Step(title: "5", state: .active)
            ])
            
            VStack(alignment: .leading) {
                Text("msg_document_verifying".localized)
                    .font(.defaultLargeTitle)
                    .foregroundColor(.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                Spacer()
            }.padding()
            
            Spacer()
            VStack(spacing: 12) {
                ButtonView(title: "button_continue".localized) {
                    onNext?()
                }.hidden()
                
                BrandView(isDarked: true)
            }.padding()
        }
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavBackButton(isWhiteBackground: false) {
                    onBack?()
                }
            }
        }
        .onAppear {
            onNext?()
        }
    }
}

#Preview {
    DocumentVerifyingView()
}
