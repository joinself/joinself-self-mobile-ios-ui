//
//  Untitled.swift
//  SelfUI
//
//  Created by Long Pham on 15/11/24.
//

import SwiftUI

public struct DocumentItem: Hashable, Identifiable {
    public var title: String
    public var label: String
    public var iconName: String?
    public let isParent: Bool
    public var children: [DocumentItem]? = nil
    public let id = UUID()
    public init(title: String, isParent: Bool, iconName: String? = nil, label: String = "", children: [DocumentItem]? = nil) {
        self.title = title
        self.isParent = isParent
        self.children = children
        self.iconName = iconName
        self.label = label
    }
}

public struct ParentChildView: View {
    let items: [DocumentItem]
    public init(items: [DocumentItem]) {
        self.items = items
        
    }
    
    public var body: some View {
        List(items, children: \.children) { item in
            if item.isParent {
                ItemView(title: item.title, iconName: item.iconName)
                    .listRowSeparatorTint(.white)
                    .listRowSpacing(0)
                    .backgroundStyle(.orange)
                    .background(.white)
                    .listRowBackground(Color.white)
                    .scrollContentBackground(.hidden)
                    .background(.yellow)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                //                        .listRowInsets(EdgeInsets())
                    .tint(Color.white)
            } else {
                ItemView(title: item.title, iconName: item.iconName)
                    .listRowBackground(Color.white)
                    .scrollContentBackground(.hidden)
                    .background(.white)
                    .listRowSeparator(.visible)
                //                    .listRowInsets(EdgeInsets())
            }
        }
        .disclosureGroupStyle(CustomDisclosureGroupStyle())
        .listItemTint(.blue)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.white)
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ParentChildView(items: [DocumentItem(title: "Passport",isParent: true, iconName: "VN", children: [DocumentItem(title: "Given Names",
                                                                                                                       isParent: false),
                                                                                                          DocumentItem(title: "Nationality",
                                                                                                                       isParent: false)]),
                                DocumentItem(title: "National Identity",
                                             isParent: true,
                                             children: [
                                                DocumentItem(title: "Given Names",
                                                             isParent: false,
                                                             children:[DocumentItem(title: "Next Task", isParent: false)]),
                                                DocumentItem(title: "Nationality",
                                                             isParent: true,
                                                             children: [DocumentItem(title: "Expiry data", isParent: false)])])])
    }
}
