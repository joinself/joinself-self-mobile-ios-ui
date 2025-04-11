//
//  CreatingAccountView.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI
import UserNotifications

public struct CreatingAccountView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var notificationPermissionGranted = false
    
    var onNext: (() -> ())?
    public init(onNext: (() -> Void)? = nil) {
        self.onNext = onNext
    }
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 5){
            VStack (spacing: 30) {
                Text("creating_account_title".localized)
                    .modifier(Heading2TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                
                Text("creating_account_description".localized)
                    .modifier(Body1TextStyle())
                
                Spacer()
                LoadingDotsView()
                Spacer()
            }
            
            ButtonView(title: "button_turn_on_notifications".localized) {
                onNext?()
            }
        }
    }
}

#Preview {
    CreatingAccountView()
}
