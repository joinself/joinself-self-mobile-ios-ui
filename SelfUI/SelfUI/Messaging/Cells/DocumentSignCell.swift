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

struct DocumentSignRejectedCell: View {
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
        VStack (alignment: .leading) {
            HStack {
                Image("ic_document_sign", bundle: mainBundle)
                Text(messageDTO.text)
                    .multilineTextAlignment(.leading)
                    .font(.defaultBody)
                    .foregroundStyle(Color.textPrimary)
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
                DocumentSignContentCell(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject)
            case .rejected:
                DocumentSignAcceptedContentCell(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject)
            default:
                DocumentSignRejectedCell(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject)
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
