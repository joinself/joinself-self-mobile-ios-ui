//
//  NavigationTitleView.swift
//  SelfUI
//
//  Created by Long Pham on 28/9/24.
//

import SwiftUI

public struct NavigationTitleView: View {
    @Binding var title: String
    @Binding var font: Font
    let imageURL: URL?
    @Binding var isOn: Bool
    let switchable: Bool
    public init(title: Binding<String> = .constant(""), switchable: Bool = true, isOn: Binding<Bool> = .constant(false), font: Binding<Font> = .constant(.navigationTitle), imageURL: URL? = nil) {
        self._title = title
        self.imageURL = imageURL
        self._font = font
        self._isOn = isOn
        self.switchable = switchable
    }
    public var body: some View {
        HStack {
            if switchable {
                Toggle(isOn: $isOn) {
                    Text(title)
                        .modifier(Heading4TextStyle(lineLimit: 1, truncationMode: .tail, scale: 1.0))
                }
                .toggleStyle(ImageToggleStyle(onColor: .defaultGray, offColor: .defaultGray, thumbImageOn: Image("ic_self_logo", bundle: mainBundle), thumbImageOff: Image("ic_logo_quaternary", bundle: mainBundle)))
                Spacer()
            } else {
                if let imageURL = imageURL {
                    AvatarView(imageURL: imageURL)
                        .frame(width: Constants.NavIconSize)
                } else {
                    AvatarView(icon: .constant(Image("ic_self_logo", bundle: mainBundle)))
                        .frame(width: Constants.NavIconSize)
                }
                Text(title)
                    .modifier(Heading4TextStyle(lineLimit: 1, truncationMode: .tail, scale: 1.0))
                
                Spacer()
            }
            
        }
    }
}

#Preview {
    VStack {
        NavigationTitleView(title: .constant("Messages"), imageURL: mainBundle?.url(forResource: "Image", withExtension: "jpeg"))
        NavigationTitleView(title: .constant("Messages"), switchable: false, imageURL: mainBundle?.url(forResource: "Image", withExtension: "jpeg"))
    }
    
}
