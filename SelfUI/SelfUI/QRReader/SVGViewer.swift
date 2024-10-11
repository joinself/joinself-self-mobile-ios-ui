//
//  SVGViewer.swift
//  SelfUI
//
//  Created by Long Pham on 10/10/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.maximumContentSizeCategory = .extraLarge
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

public struct SVGViewer: View {
    let url: URL?
    public init(url: URL?) {
        self.url = url
    }
    
    
    public var body: some View {
        GeometryReader(content: { geometry in
            VStack {
                if let url = url {
                    WebView(url: url)
                        .frame(width: 600, height: 600)
                        .padding(.leading, 100)
                        .onAppear {
                            print("Size: \(geometry.size)")
                        }
                    
                } else {
                    Text("SVG file not found")
                }
            }.ignoresSafeArea()
        })
        
    }
}

#Preview {
    VStack {
        
    }.sheet(isPresented: .constant(true)) {
        SVGViewer(url: mainBundle?.url(forResource: "qrcode", withExtension: "svg"))
    }
}
