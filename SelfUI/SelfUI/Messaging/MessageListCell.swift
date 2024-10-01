//
//  MessageListCell.swift
//  SelfUI
//
//  Created by Long Pham on 26/9/24.
//

import SwiftUI

public struct MessageListCell: View {
    
    private let avatarSize: CGFloat = 48
    let title: String
    let message: String
    let timestamp: String
    let badge: String
    
    public init (title: String = "",
                 message: String = "",
                 timestamp: String = "",
                 badge: String = "" ) {
        self.title = title
        self.message = message
        self.timestamp = timestamp
        self.badge = badge
    }
    
    public var body: some View {
        HStack (spacing: 10) {
            AvatarView(imageName: "avatar_path", userName: title)
                .frame(width: avatarSize, height: avatarSize)
            Spacer()
            HStack {
                VStack (alignment: .leading)  {
                    // Heading/H5
                    Text(title)
                        .font(
                            Font.custom("Barlow", size: 21)
                                .weight(.bold)
                        )
                        .foregroundColor(Color(red: 0.05, green: 0.11, blue: 0.26))
                        //.frame(width: .infinity)
                    // Subtitle/Subtitle 1
                    Text(message)
                        .font(Font.custom("Barlow", size: 17))
                        .foregroundColor(Color(red: 0.38, green: 0.42, blue: 0.48))
                }
                Spacer()
                
            }.frame(maxWidth: .infinity)
            
            Spacer()
            VStack {
                // Paragraph/Caption
                Text(timestamp)
                    .font(
                        Font.custom("SF Pro", size: 12)
                            .weight(.medium)
                    )
                    .kerning(0.12)
                    .foregroundColor(Color(red: 0.65, green: 0.67, blue: 0.71))
                
                if !badge.isEmpty {
                    Circle()
                        .foregroundStyle(Color.defaultGray)
                        .overlay(content: {
                            Text(badge)
                                .font(.defaultCaption)
                        })
                        .frame(width: 20, height: 20)
                }
                
            }
        }
//        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        List {
            MessageListCell(title: "Portal", message: "Last message", timestamp: "Yesterday", badge: "23")
            MessageListCell(title: "Custom App", message: "Last message", timestamp: "Now", badge: "")
        }.listStyle(.plain)
    }
}
