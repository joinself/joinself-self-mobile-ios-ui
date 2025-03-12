//
//  TextModifiers.swift
//  SelfUI
//
//  Created by Long Pham on 25/2/25.
//

import SwiftUI

/// Heading 1 - 64pt
public struct Heading1TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.heading1)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
            .allowsTightening(true)
            .minimumScaleFactor(0.6)
            .lineSpacing(1.14)
    }
}

public struct Heading2TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.heading2)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
            .allowsTightening(true)
            .minimumScaleFactor(0.6)
            .lineSpacing(1.14)
    }
}

/// heading text 36pt bold
public struct Heading3TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.heading3)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
            .allowsTightening(true)
            .minimumScaleFactor(0.6)
            .lineSpacing(1.14)
    }
}

// 25pt bold
public struct Heading4TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.heading4)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
            .allowsTightening(true)
            .minimumScaleFactor(0.6)
            .lineSpacing(1.14)
    }
}

/// 21 pt Bold
public struct Heading5TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.heading5)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
            .allowsTightening(true)
            .kerning(0.85)
            .minimumScaleFactor(0.6)
            .lineSpacing(1.14)
    }
}

/// 16pt bold
public struct Heading6TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.heading6)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
            .allowsTightening(true)
            .kerning(0.85)
            .minimumScaleFactor(0.6)
            .lineSpacing(1.14)
    }
}

public struct Subtitle1TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.subtitle1)
            .foregroundColor(color)
    }
}

public struct Subtitle2TextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.subtitle2)
            .foregroundColor(color)
    }
}

public struct ButtonTextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.subtitle2)
            .foregroundColor(color)
    }
}

public struct Body1TextStyle: ViewModifier {
    var color: Color = .textPrimary

    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.body1)
            .lineSpacing(1.14)
            .foregroundColor(color)
    }
}

public struct Body2TextStyle: ViewModifier {
    var color: Color = .textPrimary

    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.body2)
            .foregroundColor(color)
    }
}

public struct CaptionTextStyle: ViewModifier {
    var color: Color = .textPrimary
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
            .allowsTightening(true)
            .minimumScaleFactor(0.6)
            .lineSpacing(1.14)
    }
}

public struct Hyperlink1TextStyle: ViewModifier {
    var color: Color = .defaultBlue
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.hyperlink1)
            .underline(true, pattern: .solid)
            .foregroundColor(color)
    }
}

public struct Hyperlink2TextStyle: ViewModifier {
    var color: Color = .defaultBlue
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.hyperlink2)
            .underline(true, pattern: .solid)
            .foregroundColor(color)
    }
}

public struct CaptionLink3TextStyle: ViewModifier {
    var color: Color = .defaultBlue
    
    public init(color: Color = .textPrimary) {
        self.color = color
    }
    
    public func body(content: Content) -> some View {
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
