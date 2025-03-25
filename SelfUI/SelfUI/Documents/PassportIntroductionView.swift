//
//  PassportIntroductionView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct PassportIntroductionView: View {
    
    public init(onGettingStarted: @escaping () -> Void, onNavigateBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigateBack = onNavigateBack
    }
    
    var onGettingStarted: () -> Void
    var onNavigateBack: () -> Void
    public var onSelectNegative: (() -> Void)? = nil
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 2, content: {
            VStack (alignment: .leading, spacing: 30, content: {
                Text(String(format: "title_verify_document_introduction".localized, arguments: ["passport"]))
                    .modifier(Heading3TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Text(String(format: "msg_verify_document_introduction".localized, arguments: ["passport"]))
                    .modifier(Body1TextStyle())
            })
            
            Spacer()
            
            ButtonView(title: "button_get_started".localized) {
                onGettingStarted()
            }
        })
    }
}

#Preview {
    PassportIntroductionView(onGettingStarted: {
        
    }, onNavigateBack: {
        
    })
}
