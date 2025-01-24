//
//  FileCell.swift
//  SelfUI
//
//  Created by Long Pham on 3/10/24.
//

import SwiftUI

struct FileCell: View, BaseMessage {
    let messageDTO: MessageDTO
    let spaceLength: CGFloat = 0
    @State private var showDocument = false
    
    init(messageDTO: MessageDTO) {
        self.messageDTO = messageDTO
    }
    
    var body: some View {
        BaseCell(messageDTO: messageDTO) {
            VStack(alignment: messageDTO.fromType == .sender ? .trailing : .leading, spacing: 0) {
                VStack (alignment: .leading) {
                    HStack {
                        Image("ic_document_sign", bundle: mainBundle)
                        VStack (alignment: .leading) {
                            Text(messageDTO.attachments.first?.name ?? messageDTO.text)
                                .multilineTextAlignment(.leading)
                                .font(.defaultBody)
                                .foregroundStyle(Color.textPrimary)
                            StatusLabel(label: messageDTO.attachments.first?.formattedSize ?? "0 MB", labelColor: .defaultPink, backgroundColor: .PrimaryOverlay)
                        }
                        Spacer()
                        Image("ic_chevron_right", bundle: mainBundle)
                    }.onTapGesture {
                        print("View document.")
                        showDocument = true
                    }
                    
                }
                .sheet(isPresented: $showDocument, onDismiss: {
                    // dismiss document preview
                }, content: {
                    if let attachment = messageDTO.attachments.first, attachment.isPlayable {
                        VideoPreview(url: URL(fileURLWithPath: attachment.localPath))
                    }
                    else if let path = messageDTO.attachments.first?.localPath {
                        let url = URL(fileURLWithPath: path)
                        
                        PDFViewer(url: url)
                            .onAppear {
                                print("URL: \(url)")
                            }
                    } else {
                        PDFViewer(url: mainBundle?.url(forResource: "sample", withExtension: "pdf"))
                    }
                })
                .multilineTextAlignment(.leading)
                .font(.defaultBody)
                .foregroundStyle(Color.textPrimary)
            }
        }
    }
}

#Preview {
    ZStack {
        VStack {
            FileCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", timestamp: "now"))
            FileCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", fromType: .receiver, timestamp: "now"))
        }
    }
    
}
