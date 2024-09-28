//
//  NavigationTitleView.swift
//  SelfUI
//
//  Created by Long Pham on 28/9/24.
//

import SwiftUI

public struct NavigationTitleView: View {
    let title: String
    public init(title: String) {
        self.title = title
    }
    public var body: some View {
        HStack {
            Image("ic_self_logo", bundle: mainBundle)
            Text(title)
                .font(.defaultNavigationTitle)
                .kerning(0.5)
                .foregroundStyle(Color.textPrimary)
        }
        
    }
}

#Preview {
    NavigationTitleView(title: "Messages")
}
