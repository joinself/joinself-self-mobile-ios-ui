//
//  CustomSmsView.swift
//  SelfUI
//
//  Created by Long Pham on 31/7/24.
//

import SwiftUI
import MessageUI

struct CustomSmsView: View {
    @State private var isShowingMessageCompose = false
    @State private var messageResult: MessageComposeResult? = nil
    
    let phoneNumber: String
    let textMessage: String
    
    var body: some View {
        VStack {
            
        }.sheet(isPresented: $isShowingMessageCompose) {
            MessageComposeView(recipients: [phoneNumber], body: textMessage, result: $messageResult)
        }.onAppear {
            isShowingMessageCompose = true
        }
        if let result = messageResult {
            Text("Message Result: \(resultDescription(result))")
        }
    }
    
    func resultDescription(_ result: MessageComposeResult) -> String {
        switch result {
        case .cancelled:
            return "Cancelled"
        case .sent:
            return "Sent"
        case .failed:
            return "Failed"
        @unknown default:
            return "Unknown"
        }
    }
}

#Preview {
    CustomSmsView(phoneNumber: "123456789", textMessage: "text message")
}
