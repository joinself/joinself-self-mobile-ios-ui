//
//  MessageTextCell.swift
//  SelfUI
//
//  Created by Long Pham on 3/10/24.
//

import SwiftUI

protocol BaseMessage {
    var messageDTO: MessageDTO { get }
}

struct MessageTextCell: View, BaseMessage {
    @ObservedObject var messageDTO: MessageDTO

    init(messageDTO: MessageDTO) {
        self.messageDTO = messageDTO
    }
    var body: some View {
        BaseCell(messageDTO: messageDTO) {
            VStack(alignment: messageDTO.fromType == .sender ? .trailing : .leading, spacing: 0) {
                Text(LocalizedStringKey(messageDTO.text))
                    .modifier(Body1TextStyle())
            }
        }
    }
}

#Preview {
    ZStack {
        VStack {
            MessageTextCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "*Hello*", timestamp: "now"))
            MessageTextCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "**Hello**", timestamp: "now"))
            MessageTextCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "```Code block```", timestamp: "now"))
            MessageTextCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, timestamp: "now"))
        }
    }
    
}
