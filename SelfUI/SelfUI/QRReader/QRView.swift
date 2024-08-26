//
//  QRView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI
import VisionKit

struct QRView: View {
    @State private var scannedCode: String = ""
    @State private var isScanning: Bool = false
    
    var body: some View {
        VStack {
            if isScanning {
                QRScannerView(scannedCode: $scannedCode)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text(scannedCode.isEmpty ? "No QR code scanned yet" : "Scanned QR code: \(scannedCode)")
                    .padding()
                Button(action: {
                    isScanning = true
                }) {
                    Text("Start Scanning")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    QRView()
}

