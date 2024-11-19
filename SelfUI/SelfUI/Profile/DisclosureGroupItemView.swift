//
//  DisclosureGroupItemView.swift
//  SelfUI
//
//  Created by Long Pham on 19/11/24.
//

import SwiftUI

struct CustomDisclosureGroupStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button(action: {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            }) {
                HStack {
                    configuration.label
                    Image(configuration.isExpanded ? "ic_chevron_down" : "ic_chevron_right", bundle: mainBundle)
                }
            }
            if configuration.isExpanded {
                configuration.content
            }
        }.background(.white)
    }
}

public struct DisclosureGroupItemView: View {
    let items: [DocumentItem]
    public init(items: [DocumentItem]) {
        self.items = items
    }
    
    public var body: some View {
        ScrollView {
            ForEach(items) { item in
                DisclosureGroup {
                    if let children = item.children {
                        VStack {
                            ForEach(children) { child in
                                ItemView(title: child.title, iconName: child.iconName)
                                    .listRowInsets(EdgeInsets(top: 0, leading: Constants.PadLeading, bottom: 0, trailing: 0))
                            }
                        }
                    }
                } label: {
                    ItemView(title: item.title, iconName: item.iconName)
                        .background(Color.white)
                }
                .disclosureGroupStyle(CustomDisclosureGroupStyle())
                .accentColor(Color.defaultDark)
                .foregroundColor(Color.defaultDark)
                .background(Color.white)
            }
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .background(Color.white)
        .listRowInsets(.none)
    }
}

#Preview {
    DisclosureGroupItemView(items: [DocumentItem(title: "Passport",isParent: true, iconName: "VN", children: [DocumentItem(title: "Given Names",
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
