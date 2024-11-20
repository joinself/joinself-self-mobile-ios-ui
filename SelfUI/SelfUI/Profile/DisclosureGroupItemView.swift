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
        }
        .background(.white)
    }
}

public struct DisclosureGroupItemView: View {
    let items: [DocumentItem]
    public init(items: [DocumentItem]) {
        self.items = items
    }
    
    public var body: some View {
        List {
            ForEach(items) { item in
                Section {
                    DisclosureGroup {
                        if let children = item.children {
                            VStack {
                                ForEach(children) { child in
                                    OutlineTextField(label: child.label, text: .constant(child.title))
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
                .listRowBackground(Color.white)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.white)
        .listRowInsets(.none)
    }
    
}

#Preview {
    VStack {
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
    .padding()
}
