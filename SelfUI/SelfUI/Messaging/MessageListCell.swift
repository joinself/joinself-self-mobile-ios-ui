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
        HStack (alignment: .top, spacing: 4) {
            AvatarView(icon: .constant(chatHistory.icon), displayName: chatHistory.title, imageURL: chatHistory.imageURL)
                .frame(width: Constants.AvatarSizeSmall)
            Spacer()
            HStack {
                VStack (alignment: .leading)  {
                    if let attributedString = createCustomMarkdownText() {
                        Text(attributedString)
                            .modifier(Body1TextStyle(color: .colorTextTertiary, font: .body1))
                    }
                    
                    if let appName = chatHistory.appName {
                        ChipView(text: appName, color: Color.colorSecondary)
                    }
                    
                    Text(chatHistory.timestamp)
                        .modifier(CaptionTextStyle(color: .textTimestamp))
                }
                Spacer()
            }
            
            Spacer()
            VStack {
                if !chatHistory.badge.isEmpty {
                    BadgeView(badge: chatHistory.badge)
                }
                
            }
        }
    }
    
    private func shortenedString(_ text: String, length: Int = 80) -> String {
        if text.count > length {
            return String(text.prefix(length)) + "..."
        } else {
            return text
        }
    }
    
    private func createCustomMarkdownText() -> AttributedString? {
        let shortenTitle = self.shortenedString(chatHistory.title)
        
        let markdownText = "**\(shortenTitle)** \(chatHistory.subtitle)"
        
        do {
            var attributedString = try AttributedString(markdown: markdownText)
            if let range = attributedString.range(of: "\(shortenTitle)") {
                attributedString[range].font =
                    .body.bold()
                attributedString[range].foregroundColor = .colorTextPrimary
            }
            
            return attributedString
        } catch {
            print("Error parsing Markdown: \(error)")
            return nil
        }
    }
    
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        List {
            MessageListCell(chatHistory: ChatHistory(id: UUID().uuidString, title: "ACME", subtitle: "Hello World", timestamp: "now", badge: "1", icon: Image("ic_self_logo", bundle: mainBundle), imageURL: nil))
            MessageListCell(chatHistory: ChatHistory(id: UUID().uuidString, title: "ACME", subtitle: "Hello World", timestamp: "now", badge: "1", icon: Image("ic_self_logo", bundle: mainBundle), imageURL: nil, appName: "Self Group"))
            MessageListCell(chatHistory: ChatHistory(id: UUID().uuidString, title: "005372ca696bd2f6c8b61fa2a6825c307754be75a29ff05a3ef19d80bbd7a01cfd", subtitle: "Hello World", timestamp: "now", badge: "1", icon: Image("ic_self_logo", bundle: mainBundle), imageURL: nil, appName: "Self Group"))
        }.listStyle(.plain)
    }
}
