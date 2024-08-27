//
//  ContentView.swift
//  Example
//
//  Created by Long Pham on 14/5/24.
//

import SwiftUI
import SelfUI

struct ContentView: View {
    @State private var path: [Int] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                NavigationLink("Create Account", value: 0)
                NavigationLink("QR Reader", value: 1)
            }
            .navigationDestination(for: Int.self) { destination in
                switch destination {
                case 0:
                    CreateAccountFlow()
                    
                case 1:
                    QRReaderView()
//
                default:
                    Text("0")
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
}
