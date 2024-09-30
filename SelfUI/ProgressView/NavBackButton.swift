//
//  NavBackButton.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

public struct NavBackButton: View {
    var onClick: (() -> ())?
    private let iconName: String
    
    public init(isWhiteBackground: Bool = false, onClick: (() -> Void)? = nil) {
        self.onClick = onClick
        iconName = isWhiteBackground ? chevon_white : chevon_dark
    }
    
    private let chevon_dark = "ic_back_dark"
    private let chevon_white = "chevron_back_white"
    public var body: some View {
        HStack {
            Image(iconName, bundle: mainBundle)
                .foregroundStyle(.black)
                .accentColor(.white)
                //.padding()
        }.onTapGesture {
            onClick?()
        }
    }
}

#Preview {
    ZStack {
        Color.purple.ignoresSafeArea()
        VStack {
            NavBackButton()
            NavBackButton(isWhiteBackground: true)
        }
    }
    
}
