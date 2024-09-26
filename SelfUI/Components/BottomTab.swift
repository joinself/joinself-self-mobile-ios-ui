//
//  BottomTab.swift
//  SelfUI
//
//  Created by Long Pham on 26/9/24.
//

import SwiftUI

struct BottomTab: View {
    let title: String
    let iconName: String
    let bundle: Bundle?
    private let defaultColor: Color = .defaultGray
    private let selectedColor: Color = .defaultBlue
    @Binding var isSelected: Bool
    init(title: String = "Title", iconName: String = "ic_data", isSelected: Binding<Bool>, bundle: Bundle? = mainBundle) {
        self.title = title
        self.iconName = iconName
        self.bundle = bundle
        self._isSelected = isSelected
    }
    
    var body: some View {
        Label(
            title: {
                Text(title)
                    .font(.caption)
            },
            icon: {
                Image(iconName, bundle: mainBundle)
                    .foregroundStyle(isSelected ? selectedColor : defaultColor)
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
