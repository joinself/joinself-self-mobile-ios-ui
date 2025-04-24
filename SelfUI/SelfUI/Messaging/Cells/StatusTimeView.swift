//
//  StatusTimeView.swift
//  SelfUI
//
//  Created by Long Pham on 3/10/24.
//

import SwiftUI

struct StatusTimeView: View {
    let timestamp: String
    @Binding private var status: MessageStatus
//    private var receiptImageName: String?
    
    init(timestamp: String, status: Binding<MessageStatus> = .constant(.pending)) {
        self.timestamp = timestamp
        self._status = status
    }
    var body: some View {
        HStack {
            // Caption/Regular
            Text(timestamp)
              .font(Font.defaultCaption)
              .multilineTextAlignment(.trailing)
              .foregroundColor(Color(red: 0.54, green: 0.54, blue: 0.54))
            if let receiptImageName = self.getReceiptIconName(messageStatus: status) {
                Image(receiptImageName, bundle: mainBundle)
                  .frame(width: 28, height: 28)
            }
        }
    }
    
    private func getReceiptIconName(messageStatus: MessageStatus) -> String? {
        var receiptImageName: String?
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
        
        return receiptImageName
    }
}

#Preview {
    VStack {
        StatusTimeView(timestamp: "yesterday", status: .constant(.pending))
        StatusTimeView(timestamp: "now", status: .constant(.read))
        StatusTimeView(timestamp: "now", status: .constant(.none))
    }
    
}
