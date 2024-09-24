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
    @Environment(\.presentationMode) var presentationMode
    
    var onCode: ((String?) -> Void)?
    public init(onCode: ((String?) -> Void)? = nil) {
        self.onCode = onCode
    }
    
    @State private var scannedCode: String?
    
    public var body: some View {
        ZStack {
            QRCodeScannerView {
                self.scannedCode = $0
                self.checkQRCode()
                onCode?($0)
            }
            .edgesIgnoringSafeArea(.all)
            QRCodeOverlayView(isValid: $isValidQRCode)
            
            VStack {
                HStack {
                    NavBackButton (isWhiteBackground: true) {
                        print("click.")
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
                .padding(24)
                Spacer()
            }
            .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
            .ignoresSafeArea()
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

