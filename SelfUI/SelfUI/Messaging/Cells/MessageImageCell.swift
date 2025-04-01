//
//  MessageImageCell.swift
//  SelfUI
//
//  Created by Long Pham on 10/10/24.
//

import SwiftUI

struct MessageImageCell: View, BaseMessage {
    var messageDTO: MessageDTO
    @State private var showImagePreview: Bool = false
    @State private var image: UIImage?

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
                                self.image = UIImage(contentsOfFile: url.path())
                            }
                            showImagePreview = true
                        }
                        .sheet(isPresented: $showImagePreview) {
                            
                        } content: {
                            ImagePreviewView(uiImage: $image)
                                .onAppear {
                                    print("Self image: \(self.image)")
                                }
                        }

                } else {
                    Text("Image is missing: \(messageDTO.attachments.first?.localPath)")
                }
                
                Text(messageDTO.text)
                    .modifier(Body1TextStyle())
            }
        }
    }
}

#Preview {
    let attachment = AttachmentDTO(name: "myimage.jpg", mime:  MessageType.SELF_IMAGE, localPath: mainBundle?.url(forResource: "ic_data_pdf", withExtension: "pdf")?.path() ?? "", size: 1000)
    VStack {
        MessageImageCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", attachments: [attachment], fromType: .sender, status: .pending, timestamp: "now"))
        MessageImageCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .read, timestamp: "now"))
//        MessageImageCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .rejected, timestamp: "now"))
    }.padding()
    
}
