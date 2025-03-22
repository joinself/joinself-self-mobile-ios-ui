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
        BaseProgressView (totalSteps: 5, activeStep: 4, content: {
            VStack(alignment: .leading) {
                Text("msg_document_verifying".localized)
                    .modifier(Heading1TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                Spacer()
            }
            Spacer()
        })
        .onAppear {
            onNext?()
        }
    }
}

#Preview {
    DocumentVerifyingView()
}
