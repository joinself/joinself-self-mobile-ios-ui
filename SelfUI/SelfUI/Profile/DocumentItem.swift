//
//  Untitled.swift
//  SelfUI
//
//  Created by Long Pham on 15/11/24.
//

import SwiftUI

public struct DocumentItem: Hashable, Identifiable {
    var title: String
    let isParent: Bool
    var children: [DocumentItem]? = nil
    public let id = UUID()
    public init(title: String, isParent: Bool, children: [DocumentItem]? = nil) {
        self.title = title
        self.isParent = isParent
        self.children = children
        
    }
}

public struct ParentChildView: View {
    let items: [DocumentItem]
    public init(items: [DocumentItem]) {
        self.items = items
        
        UITableView.appearance().separatorStyle = .none
           UITableViewCell.appearance().backgroundColor = .green
           UITableView.appearance().backgroundColor = .green
    }
    
    public var body: some View {
        List(items, children: \.children) { item in
            if item.isParent {
                ItemView(title: item.title, icon: nil)
                .listRowSeparatorTint(.white)
                .listRowSpacing(0)
                .backgroundStyle(.orange)
                .background(.white)
                .listRowBackground(Color.white)
                .background(.yellow)
                .listRowSeparator(.hidden)
//                        .listRowInsets(EdgeInsets())
                .tint(Color.white)
            } else {
                ItemView(title: item.title, icon: nil)
                .listRowBackground(Color.white)
                .background(.white)
                .listRowSeparator(.visible)
//                    .listRowInsets(EdgeInsets())
            }
        }
        .listItemTint(.blue)
        .listStyle(.plain)
//            .background()
//            .background(Color.white)
        .foregroundStyle(.white)
        .listRowBackground(Color.white)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ParentChildView(items: [DocumentItem(title: "Passport",
                                                 isParent: true,
                                                 children: [DocumentItem(title: "Given Names",
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
