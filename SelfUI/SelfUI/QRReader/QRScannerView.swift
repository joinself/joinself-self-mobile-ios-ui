//
//  QRScannerView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI
import VisionKit

struct QRScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let scannerViewController = DataScannerViewController(
            recognizedDataTypes: [.barcode()],
            qualityLevel: .accurate,
            recognizesMultipleItems: false,
            isHighFrameRateTrackingEnabled: false,
            isHighlightingEnabled: true
        )
        scannerViewController.delegate = context.coordinator
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: QRScannerView
        
        init(_ parent: QRScannerView) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            for item in addedItems {
                if case let .barcode(barcode) = item {
                    if let qrCode = barcode.payloadStringValue {
                        DispatchQueue.main.async {
                            self.parent.scannedCode = qrCode
                            dataScanner.stopScanning()
                        }
                    }
                }
            }
        }
    }
}

