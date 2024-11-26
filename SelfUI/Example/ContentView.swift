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
                
                NavigationLink {
                    ZStack {
                        Color.black.ignoresSafeArea()
                        
                        ParentChildView1(items: [DocumentItem(title: "Passport",isParent: true, iconName: "VN", children: [DocumentItem(title: "Given Names",
                                                                                                                                       isParent: false),
                                                                                                                          DocumentItem(title: "Nationality",
                                                                                                                                       isParent: false)]),
                                                DocumentItem(title: "National Identity",
                                                             isParent: true,
                                                             children: [
                                                                DocumentItem(title: "Given Names",
                                                                             isParent: false,
                                                                             children:[DocumentItem(title: "Next Task", isParent: false)]),
                                                                DocumentItem(title: "Nationality",
                                                                             isParent: true,
                                                                             children: [DocumentItem(title: "Expiry data", isParent: false)])])])
                        .background(.white)
                        .scrollContentBackground(.hidden)
                    }
                } label: {
                    Text("Display Document")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
