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
    @Environment(\.presentationMode) var presentationMode
    
    let phoneNumber: String
    let textMessage: String
    var onFinish: ((Bool) -> Void)?
    init(phoneNumber: String, textMessage: String, onFinish: ((Bool) -> Void)? = nil) {
        self.phoneNumber = phoneNumber
        self.textMessage = textMessage
        self.onFinish = onFinish
    }
    
    var body: some View {
        VStack {
            
        }.sheet(isPresented: $isShowingMessageCompose) {
            MessageComposeView(recipients: [phoneNumber], body: textMessage, dismissed: {
                presentationMode.wrappedValue.dismiss()
            }, result: $messageResult)
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
            onFinish?(false)
            return "Cancelled"
        case .sent:
            onFinish?(true)
            return "Sent"
        case .failed:
            onFinish?(false)
            return "Failed"
        @unknown default:
            onFinish?(false)
            return "Unknown"
        }
    }
}

#Preview {
    CustomSmsView(phoneNumber: "123456789", textMessage: "text message")
}
