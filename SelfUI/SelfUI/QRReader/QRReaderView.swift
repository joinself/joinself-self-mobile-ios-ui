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
    @Binding private var isValidQRCode: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var onCode: ((String?) -> Void)?
    var onCodeData: ((Data) -> Void)?
    public init(isCodeValid: Binding<Bool> = .constant(false), onCode: ((String?) -> Void)? = nil, onCodeData: ((Data) -> Void)? = nil) {
        self.onCode = onCode
        self.onCodeData = onCodeData
        self._isValidQRCode = isCodeValid
    }
    
    @State private var scannedCode: String?
    
    public var body: some View {
        ZStack {
            QRCodeScannerView {
                self.scannedCode = $0
                self.checkQRCode()
                onCode?($0)
            } didFindDataCode: { data in
                print("QR code is data: \(data.count)")
                isValidQRCode = true
                onCodeData?(data)
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

