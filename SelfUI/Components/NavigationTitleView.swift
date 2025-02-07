//
//  NavigationTitleView.swift
//  SelfUI
//
//  Created by Long Pham on 28/9/24.
//

import SwiftUI

public struct NavigationTitleView: View {
    let title: String
    @Binding var font: Font
    let imageURL: URL?
    public init(title: String, font: Binding<Font> = .constant(.navigationTitle), imageURL: URL? = nil) {
        self.title = title
        self.imageURL = imageURL
        self._font = font
    }
    public var body: some View {
        HStack {
            if let imageURL = imageURL {
                AvatarView(imageURL: imageURL, avatarSize: 30)
            } else {
                Image("ic_self_logo", bundle: mainBundle)
                    .frame(width: 30, height: 30)
            }
            
            Text(title)
                .font(font)
                .foregroundStyle(Color.textPrimary)
//                .font(.customLargeTitle)
//                .fontWeight(.semibold)
//                .kerning(0.5)
//                .foregroundStyle(Color.textPrimary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        
    }
}

#Preview {
    ZStack {
        Color.defaultBlue.ignoresSafeArea()
        NavigationTitleView(title: "Messages", imageURL: mainBundle?.url(forResource: "Image", withExtension: "jpeg"))
    }
    
}
