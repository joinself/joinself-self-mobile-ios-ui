//
//  BaseCell.swift
//  SelfUI
//
//  Created by Long Pham on 6/10/24.
//

import SwiftUI

struct BaseCell<Content: View>: View, BaseMessage {
    @ObservedObject var messageDTO: MessageDTO
    let content: Content
    private let minSpaceLength: CGFloat

    init(messageDTO: MessageDTO, spaceLength: CGFloat = Constants.SpaceLength, @ViewBuilder content: () -> Content) {
        self.messageDTO = messageDTO
        self.content = content()
        self.minSpaceLength = spaceLength
    }
    
    var body: some View {
        HStack {
            if messageDTO.isMyMessage {
                Spacer(minLength: minSpaceLength)
            }
            VStack (alignment: .trailing, spacing: 4){
                if let reference = messageDTO.reference {
                    HStack {
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(minWidth: 4, maxWidth: 4, maxHeight: .infinity)
                          .background(Color(red: 0, green: 0.78, blue: 0.53))
                          .cornerRadius(8)
                        
                        Text(LocalizedStringKey(reference.text))
                            .modifier(Body1TextStyle())
                        Spacer()
                    }
                    .background(Color.white)
                }
                content
                StatusTimeView(timestamp: messageDTO.timestamp, status: messageDTO.isMyMessage ? $messageDTO.receiptStatus : .constant(.none))
            }
            
            .padding(.horizontal, Constants.Corner2)
            .padding(.vertical, Constants.Corner3)
            .background(messageDTO.isMyMessage ? Color.defaultLightBlue : Color.defaultGray)
            .clipShape(messageDTO.isMyMessage ? .rect(
                topLeadingRadius: Constants.Corner2,
                bottomLeadingRadius: Constants.Corner2,
                bottomTrailingRadius: calculateCustomCornerRadius(),
                topTrailingRadius: Constants.Corner2
            ) : .rect(
                topLeadingRadius: Constants.Corner2,
                bottomLeadingRadius: calculateCustomCornerRadius(),
                bottomTrailingRadius: Constants.Corner2,
                topTrailingRadius: Constants.Corner2
            ))
            .overlay(
            RoundedRectangle(cornerRadius: Constants.Corner3)
            .inset(by: 1)
            .stroke(self.calculateCustomBorderColor(), lineWidth: self.calculateCustomBorderWidth())
            )
            if !messageDTO.isMyMessage {
                Spacer(minLength: minSpaceLength)
            }
        }
        // applied for all message cells
        .listRowBackground(Color.white)
        .background(.white)
        .listRowSeparator(.hidden)
        .listRowInsets(.none)
        .id(messageDTO.id)
    }
    
    private func calculateCustomCornerRadius() -> CGFloat {
        let statuses = [MessageStatus.accepted.rawValue, MessageStatus.rejected.rawValue]
        let cornerRadius = (statuses.contains(messageDTO.status.rawValue)) ? Constants.Corner2 : Constants.Corner4
        
        return cornerRadius
    }
    
    private func calculateCustomBorderWidth() -> CGFloat {
        let statuses = [MessageStatus.accepted.rawValue, MessageStatus.rejected.rawValue]
        let width: CGFloat = (statuses.contains(messageDTO.status.rawValue)) ? 2 : 0
        
        return width
    }
    
    private func calculateCustomBorderColor() -> Color {
        let color: Color = (messageDTO.status == .accepted) ? .defaultGreen : .defaultPink
        
        return color
    }
}

#Preview {
    ZStack {
        VStack {
            BaseCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, receiptStatus: .read, status: .rejected, timestamp: "now", reference: MessageDTO(id: UUID().uuidString, text: "A reference message")), spaceLength: 0, content: {
                Text("Hello base sender cell. Hello base sender cell.Hello base sender cell.Hello base sender cell.")
            })
            
            BaseCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", timestamp: "now")) {
                Text("Hello base sender cell. Hello base sender cell.Hello base sender cell.Hello base sender cell.")
            }
            
            BaseCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, timestamp: "now")) {
                Text("Hello base receier cell.")
            }
            
            BaseCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .sender, receiptStatus: .read, timestamp: "now")) {
                Text("Hello base receier cell.")
            }
            
            BaseCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .sender, receiptStatus: .read, status: .accepted, timestamp: "now")) {
                Text("Hello base receier cell.")
            }
            
            BaseCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, receiptStatus: .read, status: .accepted, timestamp: "now")) {
                Text("Hello base receier cell.")
            }
            
            BaseCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, receiptStatus: .read, status: .rejected, timestamp: "now")) {
                Text("Hello base receier cell.")
            }
            
            BaseCell(messageDTO: MessageDTO(id: UUID().uuidString, text: "Hello", fromType: .receiver, receiptStatus: .read, status: .rejected, timestamp: "now")) {
                Text("Hello base receier cell.")
            }
        }.padding()
    }
    
}
