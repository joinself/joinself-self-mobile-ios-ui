//
//  ButtonBack.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

public struct ButtonBack: View {
    var onClick: (() -> ())?
    private let iconName: String
    
    public init(isWhiteBackground: Bool = false, onClick: (() -> Void)? = nil) {
        self.onClick = onClick
        iconName = isWhiteBackground ? chevon_white : chevon_dark
    }
    
    private let chevon_dark = "ic_back_dark"
    private let chevon_white = "chevron_back_white"
    public var body: some View {
        Button {
            onClick?()
        } label: {
            Image(iconName, bundle: mainBundle)
                .foregroundStyle(.black)
                .accentColor(.white)
                .frame(width: 44, height: 44)
        }

    }
}

#Preview {
    ZStack {
        Color.purple.ignoresSafeArea()
        VStack {
            ButtonBack()
            ButtonBack(isWhiteBackground: true)
        }
    }
    
}
