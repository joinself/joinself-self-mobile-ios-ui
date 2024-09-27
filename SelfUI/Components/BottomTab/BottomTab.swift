//
//  BottomTab.swift
//  SelfUI
//
//  Created by Long Pham on 26/9/24.
//

import SwiftUI

public struct BottomTab: View {
    let title: String
    let iconName: String
    let bundle: Bundle?
    private let defaultColor: Color = .defaultGray
    private let selectedColor: Color = .defaultBlue
    @Binding var isSelected: Bool
    public init(title: String = "Title", iconName: String = "ic_data", isSelected: Binding<Bool>, bundle: Bundle? = nil) {
        self.title = title
        self.iconName = iconName
        self.bundle = bundle
        self._isSelected = isSelected
    }
    
    public var body: some View {
        Label(
            title: {
                Text(title)
                    .font(.caption)
            },
            icon: {
                UIImageWrapperView(imageName: iconName)
                    .frame(width: 25, height: 25)
            }
        )
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        VStack {
            BottomTab(isSelected: .constant(false))
            BottomTab(isSelected: .constant(true))
        }
    }
    
}
