//
//  ContentView.swift
//  Example2
//
//  Created by Long Pham on 15/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.secondary)
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Image("face_frame")
                        .resizable()
                        .aspectRatio(nil, contentMode: .fit)
                        .edgesIgnoringSafeArea(.horizontal)
                )
        }
        .frame(width: 300, height: 300)
    }
}

#Preview {
    ContentView()
}
