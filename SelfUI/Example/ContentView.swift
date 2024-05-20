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
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
