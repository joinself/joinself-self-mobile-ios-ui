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
        BaseProgressView (totalSteps: 5, activeStep: 6, content: {
            VStack (spacing: 30) {
                Text("email_introduction_title".localized)
                    .modifier(Heading3TextStyle())
                Text("email_introduction_description".localized)
                    .modifier(Body1TextStyle())
                Spacer()
            }
            
            ButtonView(title: "button_verify_email".localized) {
                onAccept?()
            }
        })
    }
}

#Preview {
    EmailIntroView()
}
