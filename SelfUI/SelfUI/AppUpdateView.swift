//
//  AppUpdateView.swift
//  SelfUI
//
//  Created by Long Pham on 30/7/24.
//

import SwiftUI

public struct AppUpdateView: View {
    
    @Environment(\.presentationMode) var presentationMode
    public init(onAccept: (() -> Void)? = nil) {
        self.onAccept = onAccept
    }
    
    var onAccept: (() -> Void)?
    
    public var body: some View {
        BaseView {
            VStack (spacing: 30) {
                Text("update_now".localized)
                    .modifier(Heading3TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Text("msg_update_now".localized)
                    .modifier(Body1TextStyle())
                Spacer()
            }
            
            ButtonView(title: "button_update_now".localized) {
                onAccept?()
            }
        }
    }
}

#Preview {
    AppUpdateView()
}
