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

struct ContentView: View {
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
            DisclosureGroup(item.title) {
                if let children = item.children {
                    ForEach(children) { child in
                        Text(child.title)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
