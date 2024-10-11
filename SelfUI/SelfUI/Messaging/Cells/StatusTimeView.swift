//
//  StatusTimeView.swift
//  SelfUI
//
//  Created by Long Pham on 3/10/24.
//

import SwiftUI

struct StatusTimeView: View {
    let timestamp: String
    let status: MessageStatus
    private var receiptImageName: String?
    init(timestamp: String, status: MessageStatus = .pending) {
        self.timestamp = timestamp
        self.status = status
        
        switch status {
        case .sent:
            receiptImageName = "ic_message_delivered"
        case .delivered:
            receiptImageName = "ic_message_delivered"
        case .read:
            receiptImageName = "ic_message_read"
        default:
            receiptImageName = nil
        }
    }
    var body: some View {
        HStack {
            // Caption/Regular
            Text(timestamp)
              .font(Font.defaultCaption)
              .multilineTextAlignment(.trailing)
              .foregroundColor(Color(red: 0.54, green: 0.54, blue: 0.54))
            if let receiptImageName = receiptImageName {
                Image(receiptImageName, bundle: mainBundle)
                  .frame(width: 28, height: 28)
            }
        }
    }
}

#Preview {
    VStack {
        StatusTimeView(timestamp: "yesterday", status: .pending)
        StatusTimeView(timestamp: "now", status: .read)
        StatusTimeView(timestamp: "now", status: .none)
    }
    
}
