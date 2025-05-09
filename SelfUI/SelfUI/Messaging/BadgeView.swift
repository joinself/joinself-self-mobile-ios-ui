//
//  BadgeView.swift
//  SelfUI
//
//  Created by Long Pham on 6/3/25.
//

import SwiftUI

public struct BadgeView: View {
    @Binding var badge: String
    
    public init(badge: Binding<String> = .constant("")) {
        self._badge = badge
    }
    
    public var body: some View {
        Circle()
            .foregroundStyle(Color.colorPrimary)
            .overlay(content: {
                Text(badge)
                    .modifier(CaptionTextStyle(color: .white))
            })
            .frame(width: 20, height: 20)
    }
}

#Preview {
    VStack {
        BadgeView(badge: .constant("100"))
        BadgeView(badge: .constant("10"))
        BadgeView(badge: .constant("1"))
    }
}
