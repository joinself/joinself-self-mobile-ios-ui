//
//  DataAttachmentCell.swift
//  SelfUI
//
//  Created by Long Pham on 11/10/24.
//

import SwiftUI

public struct DataAttachmentCell: View {
    @Binding var message: MessageDTO
    public init(message: Binding<MessageDTO>) {
        self._message = message
    }
    
    public var body: some View {
        DocumentSignCell(messageDTO: $message, spaceLength: 0)
            .frame(maxWidth: .infinity)
            .padding()
            .padding()
    }
}

#Preview {
    DataAttachmentCell(message: .constant(MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .accepted, timestamp: "now")))
}
