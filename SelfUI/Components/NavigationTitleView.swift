//
//  NavigationTitleView.swift
//  SelfUI
//
//  Created by Long Pham on 28/9/24.
//

import SwiftUI

public struct NavigationTitleView: View {
    let title: String
    @Binding var font: Font
    let imageURL: URL?
    @Binding var isOn: Bool
    public init(title: String, isOn: Binding<Bool> = .constant(false), font: Binding<Font> = .constant(.navigationTitle), imageURL: URL? = nil) {
        self.title = title
        self.imageURL = imageURL
        self._font = font
        self._isOn = isOn
    }
    public var body: some View {
        HStack {
            Toggle(isOn: $isOn) {
                Text(title)
                    .foregroundStyle(Color.textPrimary)
                    .font(.defaultNormalTitle)
            }
            .toggleStyle(ImageToggleStyle(onColor: .defaultGray, offColor: .defaultGray, thumbImageOn: Image("ic_self_logo", bundle: mainBundle), thumbImageOff: Image("ic_logo_quaternary", bundle: mainBundle)))
            Spacer()
        }
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        NavigationTitleView(title: "Messages", imageURL: mainBundle?.url(forResource: "Image", withExtension: "jpeg"))
    }
    
}
