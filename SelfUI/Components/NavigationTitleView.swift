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
    public init(title: String, font: Binding<Font> = .constant(.navigationTitle)) {
        self.title = title
        self._font = font
    }
    public var body: some View {
        HStack {
            Image("ic_self_logo", bundle: mainBundle)
                .frame(width: 30, height: 30)
            
            Text(title)
                .font(font)
                .foregroundStyle(Color.textPrimary)
//                .font(.customLargeTitle)
//                .fontWeight(.semibold)
//                .kerning(0.5)
//                .foregroundStyle(Color.textPrimary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        
    }
}

#Preview {
    ZStack {
        Color.defaultBlue.ignoresSafeArea()
        NavigationTitleView(title: "Messages")
    }
    
}
