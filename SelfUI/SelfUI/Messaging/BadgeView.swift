//
//  BadgeView.swift
//  SelfUI
//
//  Created by Long Pham on 6/3/25.
//

import SwiftUI

public struct BadgeView: View {
    let badge: String
    
    public init(badge: String) {
        self.badge = badge
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
        BadgeView(badge: "100")
        BadgeView(badge: "10")
        BadgeView(badge: "1")
    }
}
