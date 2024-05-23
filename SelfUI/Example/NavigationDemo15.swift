//
//  NavigationDemo15.swift
//  Example
//
//  Created by Long Pham on 23/5/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
        .navigationTitle("Detail Title")
    }
}

struct NavigationDemo15: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Detail") {
                DetailView()
            }
            .navigationTitle("Home")
        }
    }
}
#Preview {
    NavigationDemo15()
}
