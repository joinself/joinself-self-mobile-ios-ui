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
                    CaptureDocumentView(captureMode: .detectIDCardMRZ)
                } label: {
                    Text("Document Capture")
                }
                
                NavigationLink {
                    VerifyDocumentFlow { image1, image2 in
                        print("Verify image: \(image1), \(image2)")
                    }
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
