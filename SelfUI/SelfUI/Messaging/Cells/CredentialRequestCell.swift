//
//  CredentialRequestCell.swift
//  SelfUI
//
//  Created by Long Pham on 6/10/24.
//

import SwiftUI

struct CredentialRequestCell: BaseView {
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
            VStack(alignment: messageDTO.fromType == .sender ? .trailing : .leading, spacing: 0) {
                HStack {
                    Image("ic_self_logo", bundle: mainBundle)
                    Text("Please share your verified email address.")
                        .multilineTextAlignment(.leading)
                        .font(.defaultBody)
                        .foregroundStyle(Color.textPrimary)
                }
                
                Image("ic_space", bundle: mainBundle)
                
                HStack (spacing: 20) {
                    CustomButton(buttonTitle: "button_accept".localized, buttonTitleColor: .defaultGreen) {
                        actionAccept?()
                    }
                    
                    CustomButton(buttonTitle: "button_reject".localized, buttonTitleColor: .defaultGreen) {
                        actionReject?()
                    }
                }
            }
        }
    }
}

#Preview {
    VStack {
        CredentialRequestCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, timestamp: "now"))
    }.padding()
    
}
