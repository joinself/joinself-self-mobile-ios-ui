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


// MARK: Toggle
struct CustomToggleStyle: ToggleStyle {
    var onColor: Color
    var offColor: Color
    var thumbColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Button(action: {
                configuration.isOn.toggle()
            }) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 30)
                    .overlay(
                        Circle()
                            .fill(thumbColor)
                            .padding(3)
                            .offset(x: configuration.isOn ? 10 : -10)
                    )
                    .animation(.easeInOut, value: configuration.isOn)
            }
        }
    }
}
