//
//  PDFViewer.swift
//  SelfUI
//
//  Created by Long Pham on 10/10/24.
//

import SwiftUI
import PDFKit

struct PDFViewRepresentable: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        if let document = PDFDocument(url: url) {
            uiView.document = document
        }
    }
}

public struct PDFViewer: View {
    let url: URL?
    public init(url: URL?) {
        self.url = url
    }
    
    public var body: some View {
        VStack {
            if let url = url {
                PDFViewRepresentable(url: url)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("PDF file not found.")
            }
        }
    }
}

#Preview {
    VStack {
        
    }.sheet(isPresented: .constant(true)) {
        PDFViewer(url: mainBundle?.url(forResource: "sample", withExtension: "pdf"))
    }
}
