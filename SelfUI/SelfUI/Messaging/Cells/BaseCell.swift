//
//  BaseCell.swift
//  SelfUI
//
//  Created by Long Pham on 6/10/24.
//

import SwiftUI

struct BaseCell<Content: View>: View, BaseMessage {
    var messageDTO: MessageDTO
    let content: Content
    private let minSpaceLength: CGFloat = 70

    init(messageDTO: MessageDTO, @ViewBuilder content: () -> Content) {
        self.messageDTO = messageDTO
        self.content = content()
    }
    
    var body: some View {
        HStack {
            if messageDTO.isMyMessage {
                Spacer(minLength: minSpaceLength)
            }
            VStack (alignment: .trailing, spacing: 4){
                content
                StatusTimeView(timestamp: messageDTO.timestamp, status: messageDTO.isMyMessage ? messageDTO.receiptStatus : .none)
            }
            
            .padding(.horizontal, Constants.Corner2)
            .padding(.vertical, Constants.Corner3)
            .background(messageDTO.isMyMessage ? Color.defaultLightBlue : Color.defaultGray)
            .clipShape(messageDTO.isMyMessage ? .rect(
                topLeadingRadius: Constants.Corner2,
                bottomLeadingRadius: Constants.Corner2,
                bottomTrailingRadius: Constants.Corner4,
                topTrailingRadius: Constants.Corner2
            ) : .rect(
                topLeadingRadius: Constants.Corner2,
                bottomLeadingRadius: Constants.Corner4,
                bottomTrailingRadius: Constants.Corner2,
                topTrailingRadius: Constants.Corner2
            ))
            if !messageDTO.isMyMessage {
                Spacer(minLength: minSpaceLength)
            }
        }
        // applied for all message cells
        .listRowBackground(Color.white)
        .background(.white)
        .listRowSeparator(.hidden)
        .listRowInsets(.none)
    }
}

#Preview {
    ZStack {
        VStack {
            BaseCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", timestamp: "now")) {
                Text("Hello base sender cell. Hello base sender cell.Hello base sender cell.Hello base sender cell.")
            }
            
            BaseCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, timestamp: "now")) {
                Text("Hello base receier cell.")
            }
            
            BaseCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .sender, receiptStatus: .read, timestamp: "now")) {
                Text("Hello base receier cell.")
            }
        }
    }
    
}
