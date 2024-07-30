//
//  Configuration.swift
//  SelfUI
//
//  Created by Long Pham on 30/7/24.
//

import SwiftUI

struct GlobalTitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .medium, design: .default))
            .foregroundColor(.primary)
            .padding()
    }
}

struct GlobalBodyTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SF Pro", size: 17))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .padding()
    }
}

extension View {
    func globalBodyTextStyle() -> some View {
        self.modifier(GlobalBodyTextStyle())
    }
}
