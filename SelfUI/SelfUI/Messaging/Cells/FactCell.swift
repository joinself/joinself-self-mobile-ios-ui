//
//  FactCell.swift
//  SelfUI
//
//  Created by Long Pham on 6/10/24.
//

import SwiftUI

struct FactCell: BaseView {
    var messageDTO: MessageDTO
    
    init(messageDTO: MessageDTO) {
        self.messageDTO = messageDTO
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
                    Button(action: {
                        
                    }, label: {
                        // Heading/H6
                        HStack(alignment: .center, spacing: 10) {
                            Text("Agree")
                              .font(
                                Font.custom("Barlow", size: 16)
                                  .weight(.bold)
                              )
                              .foregroundColor(Color(red: 0, green: 0.78, blue: 0.53))
                        }
                        .padding(.horizontal, 0)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.white)
                        .cornerRadius(8)
                        
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        HStack(alignment: .center, spacing: 10) {
                            Text("Reject")
                              .font(
                                Font.custom("Barlow", size: 16)
                                  .weight(.bold)
                              )
                              .foregroundColor(Color(red: 0.98, green: 0.13, blue: 0.57))
                        }
                        .padding(.horizontal, 0)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.white)
                        .cornerRadius(8)
                    })
                }
            }
        }
    }
}

#Preview {
    VStack {
        FactCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, timestamp: "now"))
    }.padding()
    
}
