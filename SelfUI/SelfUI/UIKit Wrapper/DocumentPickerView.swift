//
//  DocumentPickerView.swift
//  SelfUI
//
//  Created by Long Pham on 29/11/24.
//

import SwiftUI

struct DocumentPickerView: View {
    @State private var isShowingDocumentPicker = true
    @State private var selectedFileName: String?
    @State private var selectedFileURLs: [URL] = []
    
    var onSelect: (([URL]) -> Void)?
    init(onSelect: (([URL]) -> Void)? = nil) {
        self.onSelect = onSelect
    }
    
    var body: some View {
        ZStack {
            if let fileName = selectedFileName {
                Text("Selected file: \(fileName)")
                    .padding()
            } else {
                Text("No file selected")
                    .foregroundColor(.gray)
                    .padding()
            }
            
            Button(action: {
                isShowingDocumentPicker = true
            }) {
                Text("Pick a Document")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .onChange(of: self.selectedFileURLs, perform: { newValue in
            print("Files change: \(newValue)")
            onSelect?(newValue)
        })
        .sheet(isPresented: $isShowingDocumentPicker) {
            DocumentPicker(selectedFileName: $selectedFileName, selectedFileURLs: $selectedFileURLs)
        }
    }
}

#Preview {
    DocumentPickerView()
}
