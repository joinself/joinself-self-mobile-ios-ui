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
//            .padding()
    }
}

struct GlobalBodyTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("SF Pro", size: 17))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
//            .padding()
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

struct ImageToggleStyle: ToggleStyle {
    var onColor: Color
    var offColor: Color
    var thumbImageOn: Image
    var thumbImageOff: Image
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            
//            Spacer()

            Button(action: {
                configuration.isOn.toggle()
            }) {
                if !configuration.isOn {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(configuration.isOn ? onColor : offColor)
                        .frame(width: 50, height: 30)
                        .overlay(
                            thumbImageOn
                                .resizable()
                                .frame(width: 30, height: 30)
                                .offset(x: configuration.isOn ? 10 : -10)
    //                        Circle()
    //                            .fill(thumbColor)
    //                            .padding(3)
    //                            .offset(x: configuration.isOn ? 10 : -10)
                        )
                        .animation(.easeInOut, value: configuration.isOn)
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(configuration.isOn ? onColor : offColor)
                        .frame(width: 50, height: 30)
                        .overlay(
                            thumbImageOff
                                .resizable()
                                .frame(width: 30, height: 30)
                                .offset(x: configuration.isOn ? 10 : -10)
    //                        Circle()
    //                            .fill(thumbColor)
    //                            .padding(3)
    //                            .offset(x: configuration.isOn ? 10 : -10)
                        )
                        .animation(.easeInOut, value: configuration.isOn)
                }
            }
            
            configuration.label
        }
    }
}

#Preview {
    VStack {
        Toggle(isOn: .constant(true)) {
            Text("My Custom Switch")
        }
        .toggleStyle(ImageToggleStyle(onColor: .defaultGray, offColor: .defaultGray, thumbImageOn: Image("ic_self_logo", bundle: mainBundle), thumbImageOff: Image("ic_logo_quaternary", bundle: mainBundle)))
        
        Toggle(isOn: .constant(false)) {
            Text("My Custom Switch")
        }
        .toggleStyle(ImageToggleStyle(onColor: .defaultGray, offColor: .defaultGray, thumbImageOn: Image("ic_self_logo", bundle: mainBundle), thumbImageOff: Image("ic_logo_quaternary", bundle: mainBundle)))
    }
}
