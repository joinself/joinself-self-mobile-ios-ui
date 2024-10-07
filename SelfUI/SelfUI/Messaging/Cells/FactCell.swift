//
//  FactCell.swift
//  SelfUI
//
//  Created by Long Pham on 6/10/24.
//

import SwiftUI

struct FactCell: BaseView {
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
                StatusTimeView(timestamp: messageDTO.timestamp, status: .pending)
            }
        }
    }
}

#Preview {
    FactCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", timestamp: "now"))
}
