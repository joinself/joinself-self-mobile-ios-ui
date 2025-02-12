//
//  SigningRequestCell.swift
//  SelfUI
//
//  Created by Long Pham on 6/10/24.
//

import SwiftUI

struct SigningRequestContentView: View {
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

struct SigningRequestAcceptContentView: View {
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

struct SigningRequestRejectContentView: View {
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
                    print("Accept")
                }
                
                CustomButton(buttonTitle: "button_reject".localized, buttonTitleColor: .defaultPink) {
                    actionReject?()
                    print("Reject")
                }
            }
        }
    }
}

struct SigningRequestCell: View {
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
                SigningRequestContentView(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject)
            case .rejected:
                SigningRequestAcceptContentView(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject)
            default:
                SigningRequestRejectContentView(messageDTO: self.messageDTO, actionAccept: actionAccept, actionReject: actionReject)
            }
        }
    }
}

#Preview {
    VStack {
        SigningRequestCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .pending, timestamp: "now"))
        SigningRequestCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .accepted, timestamp: "now"))
        SigningRequestCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, status: .rejected, timestamp: "now"))
    }.padding()
    
}
