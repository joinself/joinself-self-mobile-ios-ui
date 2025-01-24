//
//  MessageVideoCell.swift
//  SelfUI
//
//  Created by Long Pham on 10/10/24.
//

import SwiftUI

struct MessageVideoCell: View, BaseMessage {
    var messageDTO: MessageDTO
    @State private var showVideoPreview: Bool = false
    @State private var fileURL: URL?

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
                        .onTapGesture {
                            if let fileURL = messageDTO.attachments.first?.localPath{
                                let url = URL(fileURLWithPath: fileURL)
                                self.fileURL = url
                            }
                            showVideoPreview = true
                        }
                        .sheet(isPresented: $showVideoPreview) {
                            
                        } content: {
                            VideoPreview(url: self.fileURL)
                        }

                } else {
                    Text("Image is missing: \(messageDTO.attachments.first?.localPath)")
                }
                
                Text(messageDTO.text)
                    .multilineTextAlignment(.leading)
                    .font(.defaultBody)
                    .foregroundStyle(Color.textPrimary)
            }
        }
    }
}

#Preview {
    VStack {
        MessageVideoCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .sender, status: .pending, timestamp: "now"))
        MessageVideoCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .read, timestamp: "now"))
//        MessageImageCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .rejected, timestamp: "now"))
    }.padding()
    
}
