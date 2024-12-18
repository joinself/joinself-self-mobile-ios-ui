//
//  QRReaderView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI


public struct QRReaderView: View {
    @State private var isScanning: Bool = false
    @State private var showScanQRFail: Bool = false
    @Binding private var isValidQRCode: Bool
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var qrCameraManager: QRCameraManager = QRCameraManager()
    
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
            QRCodeScannerView(qrCameraManager: self.qrCameraManager)
                .onAppear {
                    qrCameraManager.startSession()
                }
                .onDisappear {
                    qrCameraManager.stopSession()
                }
                .onReceive(qrCameraManager.capturePublisher, perform: { data in
                    print("Data count: \(data.count)")
                    isValidQRCode = true
                    DispatchQueue.main.async {
                        onCodeData?(data)
                    }
                })
                .fullScreenCover(isPresented: $qrCameraManager.notSupportedQR, onDismiss: {
                    print("Dismissed")
                    qrCameraManager.notSupportedQR = false
                }, content: {
                    QRScanFailView {
                        print("Retry scan")
                        qrCameraManager.notSupportedQR = false
                        qrCameraManager.startSession()
                    } onExit: {
                        print("Exit the scanner")
                        presentationMode.wrappedValue.dismiss()
                    }
                })
                .ignoresSafeArea()
            QRCodeOverlayView(isValid: $isValidQRCode)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    NavBackButton (isWhiteBackground: true) {
                        print("click.")
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    Spacer()
                }
                .padding()
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

