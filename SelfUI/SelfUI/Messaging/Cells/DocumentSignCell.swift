//
//  DocumentSignCell.swift
//  SelfUI
//
//  Created by Long Pham on 10/10/24.
//

import SwiftUI

struct DocumentSignContentView: View {
    var messageDTO: MessageDTO
    private var actionAccept: (() -> Void)?
    private var actionReject: (() -> Void)?
    private var viewDetails: (() -> Void)?
    
    init(messageDTO: MessageDTO,
         actionAccept: (() -> Void)? = nil,
         actionReject: (() -> Void)? = nil,
         viewDetails: (() -> Void)? = nil) {
        self.messageDTO = messageDTO
        self.actionAccept = actionAccept
        self.actionReject = actionReject
        self.viewDetails = viewDetails
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack {
                Image("ic_document_sign", bundle: mainBundle)
                VStack (alignment: .leading) {
                    Text(messageDTO.attachments.first?.name ?? messageDTO.text)
                        .modifier(Body1TextStyle())

                    StatusLabel(label: messageDTO.displayFileSize(), labelColor: .defaultPink, backgroundColor: .PrimaryOverlay)
                }
                Spacer()
                Button {
                    viewDetails?()
                } label: {
                    Image("ic_chevron_right", bundle: mainBundle)
                }
            }
            
            Image("ic_space", bundle: mainBundle)
            
            HStack (spacing: 20) {
                CustomButton(buttonTitle: "button_sign".localized, buttonTitleColor: .defaultGreen) {
                    print("Sign")
                    actionAccept?()
                }
                
                CustomButton(buttonTitle: "button_reject".localized, buttonTitleColor: .defaultPink) {
                    print("Reject")
                    actionReject?()
                }
            }
        }
    }
}

struct DocumentSignAcceptedContentView: View {
    var messageDTO: MessageDTO
    private var actionAccept: (() -> Void)?
    private var actionReject: (() -> Void)?
    private var viewDetails: (() -> Void)?
    
    init(messageDTO: MessageDTO,
         actionAccept: (() -> Void)? = nil,
         actionReject: (() -> Void)? = nil,
         viewDetails: (() -> Void)? = nil) {
        self.messageDTO = messageDTO
        self.actionAccept = actionAccept
        self.actionReject = actionReject
        self.viewDetails = viewDetails
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack {
                Image("ic_document_signed", bundle: mainBundle)
                VStack (alignment: .leading) {
                    Text(messageDTO.text)
                        .modifier(Body1TextStyle())
                    HStack {
                        StatusLabel(label: "label_signed".localized, backgroundColor: .defaultGreen)
                        StatusLabel(label: self.messageDTO.displayFileSize(), labelColor: .defaultGreen, backgroundColor: .white)
                    }
                }
                Spacer()
                Button {
                    viewDetails?()
                } label: {
                    Image("ic_chevron_right", bundle: mainBundle)
                }
            }
        }
        .frame(minWidth: Constants.SystemCellMinWidth)
    }
}

struct DocumentSignRejectedContentView: View {
    var messageDTO: MessageDTO
    private var actionAccept: (() -> Void)?
    private var actionReject: (() -> Void)?
    private var viewDetails: (() -> Void)?
    
    init(messageDTO: MessageDTO,
         actionAccept: (() -> Void)? = nil,
         actionReject: (() -> Void)? = nil,
         viewDetails: (() -> Void)? = nil) {
        self.messageDTO = messageDTO
        self.actionAccept = actionAccept
        self.actionReject = actionReject
        self.viewDetails = viewDetails
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack {
                Image("ic_document_sign", bundle: mainBundle)
                    .tint(.defaultGreen)
                VStack (alignment: .leading) {
                    Text(messageDTO.text)
                        .modifier(Body1TextStyle())
                    
                    HStack {
                        StatusLabel(label: "label_rejected".localized, backgroundColor: .defaultError)
                        StatusLabel(label: messageDTO.displayFileSize(), labelColor: .defaultError, backgroundColor: .white)
                    }
                }
                
                Spacer()
                Button {
                    viewDetails?()
                } label: {
                    Image("ic_chevron_right", bundle: mainBundle)
                }
            }
        }
        .frame(minWidth: Constants.SystemCellMinWidth)
    }
}

public struct DocumentSignCell: View {
    @Binding var messageDTO: MessageDTO
    let spaceLength: CGFloat
    private var actionAccept: (() -> Void)?
    private var actionReject: (() -> Void)?
    
    @State private var showDocument = false
    
    public init(messageDTO: Binding<MessageDTO>,
         spaceLength: CGFloat = 20,
         actionAccept: (() -> Void)? = nil,
         actionReject: (() -> Void)? = nil) {
        self._messageDTO = messageDTO
        self.spaceLength = spaceLength
        self.actionAccept = actionAccept
        self.actionReject = actionReject
    }
    
    public var body: some View {
        BaseCell(messageDTO: messageDTO, spaceLength: spaceLength) {
            switch messageDTO.status {
            case .accepted:
                DocumentSignAcceptedContentView(messageDTO: self.messageDTO, actionAccept: nil, actionReject: nil) {
                    showDocument = true
                }
            case .rejected:
                DocumentSignRejectedContentView(messageDTO: self.messageDTO, actionAccept: nil, actionReject: nil) {
                    showDocument = true
                }
            default:
                DocumentSignContentView(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject) {
                    showDocument = true
                }
            }
        }
        .sheet(isPresented: $showDocument, onDismiss: {
            // dismiss document preview
        }, content: {
            if let path = messageDTO.attachments.first?.localPath {
                let url = URL(fileURLWithPath: path)
                
                PDFViewer(url: url)
                    .onAppear {
                        print("URL: \(url)")
                    }
            } else {
                PDFViewer(url: mainBundle?.url(forResource: "sample", withExtension: "pdf"))
            }
        })
    }
}

#Preview {
    /**
     DocumentSignCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .pending, timestamp: "now"))
     DocumentSignCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .accepted, timestamp: "now"))
     DocumentSignCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .rejected, timestamp: "now"))
     */
    ChatView(conversationName: .constant("User"), imageURL: mainBundle?.url(forResource: "Image", withExtension: "jpeg"), chatObservableObject: ChatObservableObject(messages: [
        MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", mimeType: MessageType.SELF_DOCUMENT_SIGN, fromType: .receiver, status: .pending, timestamp: "now"),
        MessageDTO(id: UUID().uuidString, text: "File A", attachments: [AttachmentDTO(name: "File A", mime: "", localPath: "", size: 1200000)], mimeType: MessageType.SELF_DOCUMENT_SIGN, fromType: .receiver, status: .accepted, timestamp: "now"),
        MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", mimeType: MessageType.SELF_DOCUMENT_SIGN, fromType: .receiver, status: .rejected, timestamp: "now"),
    ]))
    
}
