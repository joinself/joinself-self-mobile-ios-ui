//
//  CredentialRequestCell.swift
//  SelfUI
//
//  Created by Long Pham on 6/10/24.
//

import SwiftUI

struct CredentialRequestContentView: View {
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
                Image("ic_accept_request", bundle: mainBundle)
                VStack (alignment: .leading) {
                    Text(messageDTO.text)
                        .multilineTextAlignment(.leading)
                        .font(.defaultBody)
                        .foregroundStyle(Color.textPrimary)
                    
                    StatusLabel(label: "label_agreed".localized, backgroundColor: .defaultGreen)
                }
            }
        }
    }
}

struct CredentialRequestAcceptContentView: View {
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
                Image("ic_accept_request", bundle: mainBundle)
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

struct CredentialRequestRejectContentView: View {
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
                Image("ic_custom_app", bundle: mainBundle)
                Text(messageDTO.text)
                    .multilineTextAlignment(.leading)
                    .font(.defaultBody)
                    .foregroundStyle(Color.textPrimary)
            }
            
            Image("ic_space", bundle: mainBundle)
            
            HStack (spacing: 20) {
                CustomButton(buttonTitle: "button_agree".localized, buttonTitleColor: .defaultGreen) {
                    actionAccept?()
                }
                
                CustomButton(buttonTitle: "button_reject".localized, buttonTitleColor: .defaultPink) {
                    actionReject?()
                }
            }
        }
    }
}

public struct CredentialRequestCell: View {
    @Binding var messageDTO: MessageDTO
    private var actionAccept: (() -> Void)?
    private var actionReject: (() -> Void)?
    
    public init(messageDTO: Binding<MessageDTO>,
         actionAccept: (() -> Void)? = nil,
         actionReject: (() -> Void)? = nil) {
        self._messageDTO = messageDTO
        self.actionAccept = actionAccept
        self.actionReject = actionReject
    }
    
    public var body: some View {
        BaseCell(messageDTO: messageDTO) {
            switch messageDTO.status {
            case .accepted:
                CredentialRequestContentView(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject)
            case .rejected:
                CredentialRequestAcceptContentView(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject)
            default:
                CredentialRequestRejectContentView(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject)
            }
        }
    }
}

#Preview {
    VStack {
        CredentialRequestCell(messageDTO: .constant(MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .pending, timestamp: "now")))
        CredentialRequestCell(messageDTO: .constant(MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .accepted, timestamp: "now")))
        CredentialRequestCell(messageDTO: .constant(MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .rejected, timestamp: "now")))
    }
}
