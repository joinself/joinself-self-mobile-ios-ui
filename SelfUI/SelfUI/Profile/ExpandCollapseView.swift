//
//  Item.swift
//  SelfUI
//
//  Created by Long Pham on 15/11/24.
//


import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    var children: [Item]?
}

public struct CustomDisclosureGroup: View {
    @State private var isExpanded = false
    let title: String
    let imageName: String
    public init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    
    public var body: some View {
        VStack {
            if isExpanded {
                Text("Test")
            } else {
                ParentItemView(title: title, imageName: imageName)
            }
            
            //            .padding()
            //            .background(Color.gray.opacity(0.2))
            //            .cornerRadius(8)
            //            .transition(.slide)
        }
        //        .padding()
    }
}

struct CustomDisclosureGroup1: View {
    @State private var isExpanded = false
    let items: [Item] = [
        Item(title: "Fruits", children: [
            Item(title: "Apple"),
            Item(title: "Banana"),
            Item(title: "Orange")
        ]),
        Item(title: "Vegetables", children: [
            Item(title: "Carrot"),
            Item(title: "Broccoli"),
            Item(title: "Spinach")
        ])
    ]
    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                VStack(alignment: .leading) {
                    ForEach(items) { item in
                        HStack {
                            Text(item.title)
                            Spacer()
                        }
                    }
//                    Text(items.first!.title)
//                        .padding()
//                    Text("Here is some detailed content that is revealed when the group is expanded.")
//                        .padding()
                }
            },
            label: {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Custom Header")
                        .font(.headline)
                    Spacer()
//                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
//                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            }
        )
        .padding()
    }
}

struct ExpandCollapseView: View {
    @State private var isExpanded = false
    
    let items: [Item] = [
        Item(title: "Fruits", children: [
            Item(title: "Apple"),
            Item(title: "Banana"),
            Item(title: "Orange")
        ]),
        Item(title: "Vegetables", children: [
            Item(title: "Carrot"),
            Item(title: "Broccoli"),
            Item(title: "Spinach")
        ])
    ]
    
    var body: some View {
        List(items, children: \.children) { item in
            CustomDisclosureGroup(title: item.title, imageName: "GB")
            //            ParentItemView(title: item.title, imageName: imageName)
        }
        .listStyle(.plain)
    }
}

#Preview {
    //    ExpandCollapseView()
    VStack {
        CustomDisclosureGroup1()
        Spacer()
    }
}
