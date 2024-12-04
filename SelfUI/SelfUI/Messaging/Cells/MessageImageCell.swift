//
//  MessageImageCell.swift
//  SelfUI
//
//  Created by Long Pham on 10/10/24.
//

import SwiftUI

struct MessageImageCell: View, BaseMessage {
    var messageDTO: MessageDTO

    init(messageDTO: MessageDTO) {
        self.messageDTO = messageDTO
    }
    
    var body: some View {
        BaseCell(messageDTO: messageDTO) {
            VStack(alignment: messageDTO.fromType == .sender ? .trailing : .leading, spacing: 0) {
                if let uiImage = messageDTO.image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                } else if let fileURL = messageDTO.attachments.first?.localPath{
                    let url = URL(fileURLWithPath: fileURL)
                    let image = UIImage(contentsOfFile: url.path()) ?? UIImage()
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                } else {
                    Text("Image is missing: \(messageDTO.attachments.first?.localPath)")
                }
                
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
    VStack {
        MessageImageCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .sender, status: .pending, timestamp: "now"))
        MessageImageCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .read, timestamp: "now"))
//        MessageImageCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .rejected, timestamp: "now"))
    }.padding()
    
}
