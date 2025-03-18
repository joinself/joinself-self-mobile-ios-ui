//
//  DisclosureGroupItemView.swift
//  SelfUI
//
//  Created by Long Pham on 19/11/24.
//

import SwiftUI

public struct CustomDisclosureGroupStyle: DisclosureGroupStyle {
    public init() {
        
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
//            if !configuration.isExpanded {
//                Color.pink.ignoresSafeArea()
//            }
            
            VStack {
                Button(action: {
                    withAnimation {
                        configuration.isExpanded.toggle()
                    }
                }) {
                    ZStack {
                        Color.clear.ignoresSafeArea()
                        HStack {
                            configuration.label
                            Image(configuration.isExpanded ? "ic_chevron_down" : "ic_chevron_right", bundle: mainBundle)
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 66, maxHeight: 66, alignment: .leading)
                    .background(Color.defaultGray)
                    .cornerRadius(.defaultCornerRadius)
                    
                }
                if configuration.isExpanded {
                    configuration.content
                }
            }
            .padding(0)
            .background(.clear)
        }
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
                            Group {
                                ForEach(children) { child in
                                    OutlineTextField(label: child.label, text: .constant(child.title))
                                        .padding(.leading, 16)
                                }
                            }
                        }
                    } label: {
                        ItemView(title: item.title, iconName: item.iconName)
                    }
                    .disclosureGroupStyle(CustomDisclosureGroupStyle())
                    .accentColor(Color.defaultDark)
                    .foregroundColor(Color.defaultDark)
                    .background(Color.white)
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                }
                .listSectionSeparator(.hidden)
                .listRowBackground(Color.white)
            }
        }
        .listStyle(.plain)
        .listRowSeparator(.hidden)
        .scrollContentBackground(.hidden)
        .background(Color.white)
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
//    .padding()
}
