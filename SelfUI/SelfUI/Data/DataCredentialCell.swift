//
//  CredentialCell.swift
//  SelfUI
//
//  Created by Long Pham on 11/10/24.
//

import SwiftUI

public struct DataCredentialCell: View {
    let message: MessageDTO
    public init(message: MessageDTO) {
        self.message = message
    }
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Paragraph/Body Secondary
            Text(message.credential?.subject ?? "")
                .font(.defaultCaption)
                .foregroundColor(.textPrimary)
            // Heading/H5
            Text(message.credential?.value ?? "")
                .font(
                    Font.custom("Barlow-Bold", size: 21)
                )
                .foregroundStyle(Color.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
            // Link/Caption Link
            Text(message.credential?.signer ?? "")
                .font(
                    .defaultCaption
                )
                .kerning(0.12)
                .underline()
                .foregroundColor(.textPrimary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(Color.defaultGray)
        .cornerRadius(10)
    }
}

#Preview {
    DataCredentialCell(message: MessageDTO(id: UUID().uuidString, text: "Hello", credential: CredentialDTO(subject: "Email", value: "abc@dot.com", signer: "Mr.S"), fromType: .receiver, status: .accepted, timestamp: "now"))
}
