//
//  QRCodeScannerView.swift
//  SelfUI
//
//  Created by Long Pham on 27/8/24.
//

import SwiftUI
import AVFoundation

struct QRCodeScannerView: UIViewControllerRepresentable {
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRCodeScannerView
        var captureSession: AVCaptureSession?
        init(parent: QRCodeScannerView) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                
                
                guard let stringValue = readableObject.stringValue else {
                    print("metadataObjects: \(readableObject.type) not string value")
                    print("metadataObjects descriptor: \(readableObject.descriptor?.description)")
                    if let descriptor = readableObject.descriptor as? CIQRCodeDescriptor {
                        let dataError = descriptor.errorCorrectedPayload
                        let bytes = descriptor.maskPattern
                        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                        parent.didFindDataCode(dataError)
                        
                        print("Data error: \(dataError.count)")
                        print("Mask pattern: \(bytes)")
                        self.stopSession()
                    }
                    return
                }
                
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                parent.didFindCode(stringValue)
                self.stopSession()
            }
        }
        
        private func stopSession() {
            print("Stop capture session.")
            captureSession?.stopRunning()
        }
    }
    
    var didFindCode: (String) -> Void
    var didFindDataCode: (Data) -> Void
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        context.coordinator.captureSession = captureSession
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return viewController }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return viewController
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return viewController
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return viewController
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = viewController.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .background).async {
            captureSession.startRunning()
        }
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
