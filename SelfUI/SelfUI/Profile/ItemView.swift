//
//  ItemView.swift
//  SelfUI
//
//  Created by Long Pham on 19/11/24.
//

import SwiftUI

public struct ItemView: View {
    public let title: String
    public let iconName: String?
    public init(title: String, iconName: String? = nil) {
        self.title = title
        self.iconName = iconName
    }
    
    public var body: some View {
        HStack {
            if let iconName = iconName {
                Image(iconName, bundle: mainBundle)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: Constants.IconSize, height: Constants.IconSize)
            }
            Text(title)
                .font(.defaultBody)
                .foregroundStyle(Color.textPrimary)
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .padding(.leading, 0)
        .listRowBackground(Color.clear)
//        .scrollContentBackground(.hidden)
        .background(Color.defaultGray)
        .listRowSeparator(.visible)
        .disclosureGroupStyle(CustomDisclosureGroupStyle())
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            ItemView(title: "Item GB", iconName: "GB")
            ItemView(title: "Item VN", iconName: "VN")
        }
    }
}
