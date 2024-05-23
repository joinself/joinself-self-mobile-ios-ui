//
//  NavigationDemoView.swift
//  Example
//
//  Created by Long Pham on 23/5/24.
//

import SwiftUI

struct NavigationDemoView: View {
    @State private var path: [Color] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                NavigationLink("Pink", value: Color.pink)
                NavigationLink("Yellow", value: Color.yellow)
                NavigationLink("Green", value: Color.green)
            }
            .navigationDestination(for: Color.self) { color in
                ColorDetail(path: $path, color: color)
            }
            .navigationTitle("Home")
        }
    }
}

struct ColorDetail: View {
    @Binding var path: [Color]
    var color: Color
    
    var body: some View {
        // Your view content
        Button("Pop View") {
            if let index = path.firstIndex(of: color) {
                path.remove(at: index)
            }
        }
        .background(color)
    }
}

#Preview {
    NavigationDemoView()
}
