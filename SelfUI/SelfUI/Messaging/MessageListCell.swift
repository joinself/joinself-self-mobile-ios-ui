//
//  MessageListCell.swift
//  SelfUI
//
//  Created by Long Pham on 26/9/24.
//

import SwiftUI

public struct MessageListCell: View {
    
    let chatHistory: ChatHistory
    private let lineLimit = 2
    
    public init (chatHistory: ChatHistory) {
        self.chatHistory = chatHistory
    }
    
    public var body: some View {
        HStack (alignment: .top, spacing: 10) {
            AvatarView(icon: .constant(chatHistory.icon), displayName: chatHistory.title, imageURL: chatHistory.imageURL)
                .frame(width: Constants.AvatarSizeSmall)
            Spacer()
            HStack {
                VStack (alignment: .leading, spacing: 4)  {
                    let formatted = "**\(chatHistory.title)** \(chatHistory.subtitle)"
                    if #available(iOS 16.1, *) {
                        Text(LocalizedStringKey(formatted))
                            .font(.defaultBody).fontDesign(.default)
                            .lineLimit(lineLimit)
                            .foregroundColor(.textSubtitle)
                    } else {
                        Text(LocalizedStringKey(formatted))
                            .modifier(Body1TextStyle())
                            .lineLimit(lineLimit)
                            .foregroundColor(.textSubtitle)
                    }
                    
                    if let appName = chatHistory.appName {
                        ChipView(text: appName, color: Color.colorSecondary)
                    }
                    
                    Text(chatHistory.timestamp)
                        .modifier(CaptionTextStyle(color: .textTimestamp))
                }
                Spacer()
                
            }.frame(maxWidth: .infinity)
            
            Spacer()
            VStack {
                if !chatHistory.badge.isEmpty {
                    BadgeView(badge: chatHistory.badge)
                }
                
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        List {
            MessageListCell(chatHistory: ChatHistory(id: UUID().uuidString, title: "ACME", subtitle: "Hello World", timestamp: "now", badge: "1", icon: Image("ic_self_logo", bundle: mainBundle), imageURL: nil))
            MessageListCell(chatHistory: ChatHistory(id: UUID().uuidString, title: "ACME", subtitle: "Hello World", timestamp: "now", badge: "1", icon: Image("ic_self_logo", bundle: mainBundle), imageURL: nil, appName: "Self Group"))
        }.listStyle(.plain)
    }
}
