//
//  TextModifiers.swift
//  SelfUI
//
//  Created by Long Pham on 25/2/25.
//

import SwiftUI

/// Heading 1 - 64pt
struct Heading1TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    func body(content: Content) -> some View {
        content
            .font(.heading1)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
            .allowsTightening(true)
            .minimumScaleFactor(0.6)
            .lineSpacing(1.14)
    }
}

struct Heading2TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    func body(content: Content) -> some View {
        content
            .font(.heading2)
            .foregroundColor(color)
    }
}

/// heading text 36pt bold
struct Heading3TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    func body(content: Content) -> some View {
        content
            .font(.heading3)
            .foregroundColor(color)
    }
}

struct Heading4TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    func body(content: Content) -> some View {
        content
            .font(.heading4)
            .foregroundColor(color)
    }
}

struct Heading5TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    func body(content: Content) -> some View {
        content
            .font(.heading5)
            .foregroundColor(color)
    }
}

struct Heading6TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    func body(content: Content) -> some View {
        content
            .font(.heading6)
            .foregroundColor(color)
    }
}

struct Subtitle1TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    func body(content: Content) -> some View {
        content
            .font(.subtitle1)
            .foregroundColor(color)
    }
}

struct Subtitle2TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    func body(content: Content) -> some View {
        content
            .font(.subtitle2)
            .foregroundColor(color)
    }
}

struct ButtonTextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    func body(content: Content) -> some View {
        content
            .font(.subtitle2)
            .foregroundColor(color)
    }
}

struct Body1TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    func body(content: Content) -> some View {
        content
            .font(.body1)
            .lineSpacing(1.14)
            .foregroundColor(color)
    }
}

struct Body2TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    func body(content: Content) -> some View {
        content
            .font(.body2)
            .foregroundColor(color)
    }
}

struct CaptionTextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    func body(content: Content) -> some View {
        content
            .font(.body2)
            .foregroundColor(color)
    }
}

struct Hyperlink1TextStyle: ViewModifier {
    var color: Color = .defaultBlue
    
    func body(content: Content) -> some View {
        content
            .font(.hyperlink1)
            .underline(true, pattern: .solid)
            .foregroundColor(color)
    }
}

struct Hyperlink2TextStyle: ViewModifier {
    var color: Color = .defaultBlue
    
    func body(content: Content) -> some View {
        content
            .font(.hyperlink1)
            .underline(true, pattern: .solid)
            .foregroundColor(color)
    }
}

struct CaptionLink3TextStyle: ViewModifier {
    var color: Color = .defaultBlue
    
    func body(content: Content) -> some View {
        content
            .font(.captionLink3)
            .underline(true, pattern: .solid)
            .foregroundColor(color)
    }
}

#Preview {
    VStack {
        Text("Welcome to Self").modifier(Heading1TextStyle())
        Text("Heading 1").modifier(Heading1TextStyle())
        Text("Heading 1")
            .modifier(Heading1TextStyle(color: .green))
        Text("Heading 2").modifier(Heading2TextStyle())
        Text("Heading 3").modifier(Heading3TextStyle())
        Text("Heading 4").modifier(Heading4TextStyle())
        Text("Heading 5").modifier(Heading5TextStyle())
        Text("Heading 6").modifier(Heading6TextStyle())
        Text("Subtitle 1").modifier(Subtitle1TextStyle())
        Text("Subtitle 2").modifier(Subtitle2TextStyle())
        Text("BUTTON").modifier(ButtonTextStyle())
        Text("Body 1").modifier(Body1TextStyle())
        Text("Body 2").modifier(Body2TextStyle())
        
        Text("Hyperlink 1").modifier(Hyperlink1TextStyle())
        Text("Hyperlink 2").modifier(Hyperlink2TextStyle())
        Text("Caption Link 3").modifier(CaptionLink3TextStyle())
        Spacer()
    }
}
