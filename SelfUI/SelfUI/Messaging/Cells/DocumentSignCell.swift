//
//  DocumentSignCell.swift
//  SelfUI
//
//  Created by Long Pham on 10/10/24.
//

import SwiftUI

struct DocumentSignContentCell: View {
    var messageDTO: MessageDTO
    private var actionAccept: (() -> Void)?
    private var actionReject: (() -> Void)?
    
    @State private var showDocument = false
    
    init(messageDTO: MessageDTO,
         actionAccept: (() -> Void)? = nil,
         actionReject: (() -> Void)? = nil) {
        self.messageDTO = messageDTO
        self.actionAccept = actionAccept
        self.actionReject = actionReject
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Image("ic_document_sign", bundle: mainBundle)
                VStack {
                    Button {
                        showDocument = true
                    } label: {
                        Text(messageDTO.attachments.first?.name ?? messageDTO.text)
                            .multilineTextAlignment(.leading)
                            .font(.defaultBody)
                            .foregroundStyle(Color.textPrimary)
                    }
                    StatusLabel(label: messageDTO.attachments.first?.size.formattedFileSize ?? "0 MB", labelColor: .defaultPink, backgroundColor: .PrimaryOverlay)
                }
                Spacer()
                Image("ic_chevron_right", bundle: mainBundle)
            }
            
            Image("ic_space", bundle: mainBundle)
            
            HStack (spacing: 20) {
                CustomButton(buttonTitle: "button_sign".localized, buttonTitleColor: .defaultGreen) {
                    actionAccept?()
                }
                
                CustomButton(buttonTitle: "button_reject".localized, buttonTitleColor: .defaultPink) {
                    actionReject?()
                }
            }
        }
        .sheet(isPresented: $showDocument, onDismiss: {
            // dismiss document preview
        }, content: {
            if let path = messageDTO.attachments.first?.localPath {
                let url = URL(fileURLWithPath: path)
                PDFViewer(url: url)
            } else {
                PDFViewer(url: mainBundle?.url(forResource: "sample", withExtension: "pdf"))
            }
        })
    }
}

struct DocumentSignAcceptedContentCell: View {
    var messageDTO: MessageDTO
    private var actionAccept: (() -> Void)?
    private var actionReject: (() -> Void)?
    
    init(messageDTO: MessageDTO,
         actionAccept: (() -> Void)? = nil,
         actionReject: (() -> Void)? = nil) {
        self.messageDTO = messageDTO
        self.actionAccept = actionAccept
        self.actionReject = actionReject
    }
    
    var body: some View {
        VStack {
            HStack {
                Image("ic_document_sign", bundle: mainBundle)
                VStack (alignment: .leading) {
                    Text(messageDTO.text)
                        .multilineTextAlignment(.leading)
                        .font(.defaultBody)
                        .foregroundStyle(Color.textPrimary)
                    
                    StatusLabel(label: "label_rejected".localized, backgroundColor: .defaultPink)
                }
            }
        }
    }
}

struct DocumentSignRejectedContentCell: View {
    var messageDTO: MessageDTO
    private var actionAccept: (() -> Void)?
    private var actionReject: (() -> Void)?
    
    init(messageDTO: MessageDTO,
         actionAccept: (() -> Void)? = nil,
         actionReject: (() -> Void)? = nil) {
        self.messageDTO = messageDTO
        self.actionAccept = actionAccept
        self.actionReject = actionReject
    }
    
    var body: some View {
        VStack {
            HStack {
                Image("ic_document_signed", bundle: mainBundle)
                    .tint(.defaultGreen)
                VStack (alignment: .leading) {
                    Text(messageDTO.text)
                        .multilineTextAlignment(.leading)
                        .font(.defaultBody)
                        .foregroundStyle(Color.textPrimary)
                    
                    StatusLabel(label: "label_signed".localized, backgroundColor: .defaultGreen)
                }
            }
        }
    }
}

struct DocumentSignCell: BaseView {
    var messageDTO: MessageDTO
    private var actionAccept: (() -> Void)?
    private var actionReject: (() -> Void)?
    
    init(messageDTO: MessageDTO,
         actionAccept: (() -> Void)? = nil,
         actionReject: (() -> Void)? = nil) {
        self.messageDTO = messageDTO
        self.actionAccept = actionAccept
        self.actionReject = actionReject
    }
    
    var body: some View {
        BaseCell(messageDTO: messageDTO) {
            switch messageDTO.status {
            case .accepted:
                DocumentSignAcceptedContentCell(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject)
            case .rejected:
                DocumentSignRejectedContentCell(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject)
            default:
                DocumentSignContentCell(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject)
            }
        }
    }
}

#Preview {
    VStack {
        DocumentSignCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .pending, timestamp: "now"))
        DocumentSignCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .accepted, timestamp: "now"))
        DocumentSignCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .rejected, timestamp: "now"))
    }.padding()
    
}
