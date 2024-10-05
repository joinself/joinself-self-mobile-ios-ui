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

public struct CustomTabItem: View {
    let imageName: String
    let title: String
    @Binding var selectedTab: Int
    let tag: Int
    
    public init(imageName: String, title: String, selectedTab: Binding<Int>, tag: Int) {
        self.imageName = imageName
        self.title = title
        self._selectedTab = selectedTab
        self.tag = tag
    }
    
    public var body: some View {
        VStack {
            Image(imageName, bundle: mainBundle)
                .renderingMode(.template)
                .foregroundColor(selectedTab == tag ? .defaultBlue : .defaultDark)
            Text(title)
                .font(.defaultCaption)
        }
    }
}


#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        VStack {
            BottomTab(isSelected: .constant(false))
            BottomTab(isSelected: .constant(true))
            
            CustomTabItem(imageName: "ic_paperclip", title: "Home", selectedTab: .constant(0), tag: 0)
            
            CustomTabItem(imageName: "ic_paperclip", title: "Home", selectedTab: .constant(1), tag: 0)
        }
    }
    
}
