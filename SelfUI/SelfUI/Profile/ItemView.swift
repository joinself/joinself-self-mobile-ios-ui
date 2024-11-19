//
//  ItemView.swift
//  SelfUI
//
//  Created by Long Pham on 19/11/24.
//

import SwiftUI

struct ItemView: View {
    let title: String
    let iconName: String?
    init(title: String, iconName: String? = nil) {
        self.title = title
        self.iconName = iconName
    }
    
    var body: some View {
        HStack {
            if let iconName = iconName {
                Image(iconName, bundle: mainBundle)
                    .clipShape(Circle())
            }
            Text(title)
                .font(.defaultBody)
                .foregroundStyle(Color.textPrimary)
            Spacer()
        }
        .listRowBackground(Color.white)
//        .scrollContentBackground(.hidden)
        .background(.white)
        .listRowSeparator(.visible)
        .disclosureGroupStyle(CustomDisclosureGroupStyle())
    }
}

#Preview {
    VStack {
        ItemView(title: "Item GB", iconName: "GB")
        ItemView(title: "Item VN", iconName: "VN")
    }
}
