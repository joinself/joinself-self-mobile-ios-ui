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
        NavigationView {
            VStack {
                NavigationLink {
                    CaptureDocumentView()
                } label: {
                    Text("Document Capture")
                }
                
                NavigationLink {
                    VerifyDocumentFlow()
                } label: {
                    Text("Verify Document")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
