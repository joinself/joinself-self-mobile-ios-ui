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
            .modifier(Body1TextStyle())
    }
}

extension View {
    func globalBodyTextStyle() -> some View {
        self.modifier(GlobalBodyTextStyle())
    }
}


// MARK: Toggle
public struct CustomToggleStyle: ToggleStyle {
    var onColor: Color
    var offColor: Color
    var thumbColor: Color
    
    public init(onColor: Color, offColor: Color, thumbColor: Color) {
        self.onColor = onColor
        self.offColor = offColor
        self.thumbColor = thumbColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
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
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(width: 30, height: 30)
                              .background(
                                thumbImageOn
                                  .resizable()
                                  .aspectRatio(contentMode: .fill)
                                  .frame(width: 30, height: 30)
                                  .clipped()
                              )
                              .cornerRadius(30)
                              .shadow(color: .black.opacity(0.2), radius: 1.5, x: -1, y: 2)
                              .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                  .inset(by: 0.5)
                                  .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1)
                              )
                              .offset(x: configuration.isOn ? 10 : -10)
//                            thumbImageOn
//                                .resizable()
//                                .frame(width: 30, height: 30)
//                                .offset(x: configuration.isOn ? 10 : -10)
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
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(width: 30, height: 30)
                              .background(
                                thumbImageOff
                                  .resizable()
                                  .aspectRatio(contentMode: .fill)
                                  .frame(width: 30, height: 30)
                                  .clipped()
                              )
                              .cornerRadius(30)
                              .shadow(color: .black.opacity(0.2), radius: 1.5, x: -1, y: 2)
                              .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                  .inset(by: 0.5)
                                  .stroke(Color(red: 0.88, green: 0.88, blue: 0.88), lineWidth: 1)
                              )
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
    .background(.secondary)
    
}
