//
//  DocumentPicker.swift
//  SelfUI
//
//  Created by Long Pham on 29/11/24.
//


import SwiftUI
import UIKit

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var selectedFileName: String?
    @Binding var selectedFileURLs: [URL]
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: DocumentPicker
        
        init(parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.selectedFileURLs = urls
            
            if let url = urls.first {
                parent.selectedFileName = url.lastPathComponent
            }
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            // Handle cancellation if needed
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.item])
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}
