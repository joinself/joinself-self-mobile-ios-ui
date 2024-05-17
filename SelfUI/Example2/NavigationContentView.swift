//
//  NavigationContentView.swift
//  Example2
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI

struct NavigationContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: LivenessIntroView()) {
                    Text("Show Full Screen Detail")
                }
            }
        }
    }
}

struct FullScreenDetailView: View {
    var body: some View {
        VStack {
            Text("This is a full-screen detail view.")
            // Add more content here as needed
        }
        .navigationBarTitle("Detail", displayMode: .inline)
        .edgesIgnoringSafeArea(.all) // This makes the view full-screen
    }
}

#Preview {
    NavigationContentView()
}
