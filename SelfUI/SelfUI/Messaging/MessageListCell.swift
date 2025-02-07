//
//  MessageListCell.swift
//  SelfUI
//
//  Created by Long Pham on 26/9/24.
//

import SwiftUI

public struct MessageListCell: View {
    
    @State private var image: UIImage?
    private let avatarSize: CGFloat = 48
    let title: String
    let message: String
    let timestamp: String
    let badge: String
    let avatarURL: URL?
    private let lineLimit = 2
    
    public init (title: String = "",
                 message: String = "",
                 timestamp: String = "",
                 badge: String = "", avatarURL: URL? = nil) {
        self.title = title
        self.message = message
        self.timestamp = timestamp
        self.badge = badge
        self.avatarURL = avatarURL
    }
    
    public var body: some View {
        HStack (spacing: 10) {
            AvatarView(imageName: "avatar_path", userName: title, imageURL: avatarURL)
                .frame(width: avatarSize, height: avatarSize)
                .padding(.bottom, 8)
                .padding(.top, 8)
            Spacer()
            HStack {
                VStack (alignment: .leading)  {
                    // Heading/H5
                    Text(title)
                        .lineLimit(lineLimit)
                        .font(.defaultMessageTitle)
                        .foregroundColor(.textPrimary)
                    if #available(iOS 16.1, *) {
                        Text(LocalizedStringKey(message))
                            .font(.defaultBody).fontDesign(.default)
                            .lineLimit(lineLimit)
                            .foregroundColor(.textSubtitle)
                    } else {
                        // Fallback on earlier versions
                    }
                }
                Spacer()
                
            }.frame(maxWidth: .infinity)
            
            Spacer()
            VStack {
                Text(timestamp)
                    .font(.defaultCaption)
                    .kerning(0.12)
                    .lineLimit(2)
                    .foregroundColor(.textTimestamp)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 80)
                
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
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        List {
            MessageListCell(title: "Portal", message: "I am going to do it. I have made up my mind. These are the first few words of the new... the best ... the Longest Text In The Entire History Of The Known Universe! This Has To Have Over 35,000 words the beat the current world record set by that person who made that flaming chicken handbooky thingy. I might just be saying random things the whole time I type in this so you might get confused a lot. I just discovered something terrible. autocorrect is on!! no!!! this has to be crazy, so I will have to break all the English language rules and the basic knowledge of the average human being. I am not an average human being, however I am special. no no no, not THAT kind of special ;). Why do people send that wink face! it always gives me nightmares! it can make a completely normal sentence creepy. imagine you are going to a friend’s house, so you text this: [ see you soon ] seems normal, right? But what is you add the word semi to that colon?", timestamp: "Yesterday", badge: "23")
            MessageListCell(title: "Custom App", message: "Last message", timestamp: "Now", badge: "")
            MessageListCell(title: "Custom App", message: "`Monospaced works too`", timestamp: "2024-12-27 10:55:45", badge: "", avatarURL: mainBundle?.url(forResource: "Image", withExtension: "jpeg"))
            MessageListCell(title: "Custom App", message: "", timestamp: "2024-12-27 10:55:45", badge: "", avatarURL: mainBundle?.url(forResource: "Image", withExtension: "jpeg"))
        }.listStyle(.plain)
    }
}
