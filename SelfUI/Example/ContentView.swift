//
//  ContentView.swift
//  Example
//
//  Created by Long Pham on 14/5/24.
//

import SwiftUI
import SelfUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LivenessView()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            // face frame
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                    .aspectRatio(1, contentMode: .fit)
                
                Image("ic_info")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .edgesIgnoringSafeArea(.horizontal)
            }
            .frame(width: 300, height: 300)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
