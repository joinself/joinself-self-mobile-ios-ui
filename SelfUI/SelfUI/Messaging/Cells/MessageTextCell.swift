//
//  MessageTextCell.swift
//  SelfUI
//
//  Created by Long Pham on 3/10/24.
//

import SwiftUI

struct Constants {
    static let Corner2: CGFloat = 16
    static let Corner3: CGFloat = 12
    static let Corner4: CGFloat = 4
    static let AvatarWidth: CGFloat = 100
    static let PadLeading: CGFloat = 12
    static let PadTop: CGFloat = 12
}

protocol BaseMessage {
    var messageDTO: MessageDTO { get }
}

struct MessageTextCell: View, BaseMessage {
    var messageDTO: MessageDTO

    init(messageDTO: MessageDTO) {
        self.messageDTO = messageDTO
    }
    
    var body: some View {
        BaseCell(messageDTO: messageDTO) {
            VStack(alignment: messageDTO.fromType == .sender ? .trailing : .leading, spacing: 0) {
                Text(messageDTO.text)
                    .multilineTextAlignment(.leading)
                    .font(.defaultBody)
                    .foregroundStyle(Color.textPrimary)
//                StatusTimeView(timestamp: messageDTO.timestamp, status: .pending)
            }
        }
    }
}

#Preview {
    ZStack {
        VStack {
            MessageTextCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", timestamp: "now"))
            MessageTextCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, timestamp: "now"))
        }
    }
    
}
