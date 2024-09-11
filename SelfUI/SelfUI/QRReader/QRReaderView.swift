//
//  QRReaderView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI
import VisionKit

public struct QRReaderView: View {
    @State private var isScanning: Bool = false
    @State private var isValidQRCode: Bool = false
    public init() {
        
    }
    
    @State private var scannedCode: String?
    
    public var body: some View {
        ZStack {
            QRCodeScannerView {
                self.scannedCode = $0
                self.checkQRCode()
            }
            .edgesIgnoringSafeArea(.all)
            QRCodeOverlayView(isValid: $isValidQRCode)
        }
    }
    
    private func checkQRCode() {
        if let scannedCode = scannedCode {
            isValidQRCode = !scannedCode.isEmpty
        }
    }
}

#Preview {
    QRReaderView()
}

