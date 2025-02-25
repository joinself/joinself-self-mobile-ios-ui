//
//  TextModifiers.swift
//  SelfUI
//
//  Created by Long Pham on 25/2/25.
//

import SwiftUI

/// Heading 1 - 64pt
struct Heading1TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.heading1)
            .foregroundColor(.textPrimary)
//            .padding()
//            .background(Color.yellow)
//            .cornerRadius(8)
    }
}

struct Heading2TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.heading2)
            .foregroundColor(.textPrimary)
    }
}

struct Heading3TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.heading3)
            .foregroundColor(.textPrimary)
    }
}

#Preview {
    VStack {
        Text("Heading 1").modifier(Heading1TextStyle())
        Text("Heading 2").modifier(Heading2TextStyle())
        Text("Heading 3").modifier(Heading3TextStyle())
    }
}
