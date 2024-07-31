//
//  CustomSmsView.swift
//  SelfUI
//
//  Created by Long Pham on 31/7/24.
//

import SwiftUI

struct CustomSmsView: View {
    @State private var isShowingMessageCompose = false
    
    var body: some View {
        VStack {
            Button("Send SMS") {
                isShowingMessageCompose = true
            }
            .sheet(isPresented: $isShowingMessageCompose) {
                MessageComposeView(recipients: ["1234567890"], body: "Hello, this is a test message.")
            }
        }
    }
}

#Preview {
    CustomSmsView()
}
