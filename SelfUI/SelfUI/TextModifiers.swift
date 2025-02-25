//
//  TextModifiers.swift
//  SelfUI
//
//  Created by Long Pham on 25/2/25.
//

import SwiftUI

/// Page title 34pt
struct PageTitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.defaultLargeTitle)
            .foregroundColor(.textPrimary)
//            .padding()
//            .background(Color.yellow)
//            .cornerRadius(8)
    }
}
#Preview {
    VStack {
        Text("Hello, World!").modifier(PageTitleTextStyle())
    }
}
