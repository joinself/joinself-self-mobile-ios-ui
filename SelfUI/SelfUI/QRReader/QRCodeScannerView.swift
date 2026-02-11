//
//  QRCodeScannerView.swift
//  SelfUI
//
//  Created by Long Pham on 27/8/24.
//

import SwiftUI
import AVFoundation
import Combine

class QRCameraManager: NSObject, ObservableObject {
    var capturePublisher = PassthroughSubject<Data, Never>()
    
    @Published var notSupportedQR: Bool = false
    fileprivate let session: AVCaptureSession = AVCaptureSession()
    
    func startSession() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
        }
    }
    
    func stopSession() {
        self.session.stopRunning()
    }
}

struct QRCodeScannerView: UIViewControllerRepresentable {
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate, ObservableObject {
        var parent: QRCodeScannerView
        var qrCameraManager: QRCameraManager
        init(parent: QRCodeScannerView, qrCameraManager: QRCameraManager) {
            self.parent = parent
            self.qrCameraManager = qrCameraManager
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                print("metadataObjects: \(readableObject.type)")
                print("metadataObjects descriptor: \(readableObject.descriptor?.description)")
                
                if let stringValue = readableObject.stringValue {
                    print("Encoded QR: \(stringValue)")
                    
                    if let data = stringValue.base64urlDecodedData() {
                        Utils.vibrate()
                        parent.qrCameraManager.stopSession()
                        parent.qrCameraManager.capturePublisher.send(data)
                    }
                    
                    /*if let encodedData = Data(base64Encoded: stringValue) {
                        print("Encoded QR: \(stringValue)")
                        Utils.vibrate()
                        parent.qrCameraManager.stopSession()
                        parent.qrCameraManager.capturePublisher.send(encodedData)
                    } else {
                        print("Not supported QR: \(stringValue)")
                        parent.qrCameraManager.notSupportedQR = true
                    }*/
                }
                else if let qrCodeBytes = readableObject.binaryValue {
                    Utils.vibrate()
                    parent.qrCameraManager.stopSession()
                    parent.qrCameraManager.capturePublisher.send(qrCodeBytes)
                }
            }
        }
    }
    var qrCameraManager: QRCameraManager
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, qrCameraManager: qrCameraManager)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        context.coordinator.qrCameraManager = qrCameraManager
        let captureSession = qrCameraManager.session
        captureSession.sessionPreset = .high
        
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


extension AVMetadataMachineReadableCodeObject
{
    var binaryValue: Data?
    {
        switch type
        {
            // TODO Add cases for PDF417 and DataMatrix
            case .qr:
                return removeQrProtocolData(binaryValueWithProtocol!)
            case .aztec:
                guard let string = stringValue else
                { return nil }
                return string.data(using: String.Encoding.isoLatin1)
            default:
                return nil
        }
    }

    var binaryValueWithProtocol: Data?
    {
        guard let descriptor = descriptor else
        {
            return nil
        }
        switch type
        {
            case .qr:
                return (descriptor as! CIQRCodeDescriptor).errorCorrectedPayload
            case .aztec:
                return (descriptor as! CIAztecCodeDescriptor).errorCorrectedPayload
            case .pdf417:
                return (descriptor as! CIPDF417CodeDescriptor).errorCorrectedPayload
            case .dataMatrix:
                return (descriptor as! CIDataMatrixCodeDescriptor).errorCorrectedPayload
            default:
                return nil
        }
    }

    private func removeQrProtocolData(_ input: Data) -> Data?
    {
        var halves = input.halfBytes()
        var batch = takeBatch(&halves)
        var output = batch
        while !batch.isEmpty
        {
            batch = takeBatch(&halves)
            output.append(contentsOf: batch)
        }
        return Data(output)
    }

    private func takeBatch(_ input: inout [HalfByte]) -> [UInt8]
    {
        let version = (descriptor! as! CIQRCodeDescriptor).symbolVersion
        let characterCountLength = version > 9 ? 16 : 8
        let mode = input.remove(at: 0)
        var output = [UInt8]()
        switch (mode.value)
        {
                // TODO If there is not only binary in the QRCode, then cases should be added here.
            case 0x04: // Binary
                let charactersCount: UInt16
                if characterCountLength == 8
                {
                    charactersCount = UInt16(input.takeUInt8())
                }
                else
                {
                    charactersCount = UInt16(input.takeUInt16())
                }
                for _ in 0..<charactersCount
                {
                    output.append(input.takeUInt8())
                }
                return output
            case 0x00: // End of data
                return []
            default:
                return []
        }
    }
}

fileprivate struct HalfByte
{
    let value: UInt8
}

fileprivate extension [HalfByte]
{
    mutating func takeUInt8() -> UInt8
    {
        let left = self.remove(at: 0)
        let right = self.remove(at: 0)
        return UInt8(left, right)
    }

    mutating func takeUInt16() -> UInt16
    {
        let first = self.remove(at: 0)
        let second = self.remove(at: 0)
        let third = self.remove(at: 0)
        let fourth = self.remove(at: 0)
        return UInt16(first, second, third, fourth)
    }
}

fileprivate extension Data
{
    func halfBytes() -> [HalfByte]
    {
        var result = [HalfByte]()
        self.forEach
            { (byte: UInt8) in result.append(contentsOf: byte.halfBytes()) }
        return result
    }

    init(_ halves: [HalfByte])
    {
        var halves = halves
        var result = [UInt8]()
        while halves.count > 1
        {
            result.append(halves.takeUInt8())
        }
        self.init(result)
    }
}

fileprivate extension UInt8
{
    func halfBytes() -> [HalfByte]
    {
        [HalfByte(value: self >> 4), HalfByte(value: self & 0x0F)]
    }

    init(_ left: HalfByte, _ right: HalfByte)
    {
        self.init((left.value << 4) + (right.value & 0x0F))
    }
}

fileprivate extension UInt16
{
    init(_ first: HalfByte, _ second: HalfByte, _ third: HalfByte, _ fourth: HalfByte)
    {
        let first = UInt16(first.value) << 12
        let second = UInt16(second.value) << 8
        let third = UInt16(third.value) << 4
        let fourth = UInt16(fourth.value) & 0x0F
        let result = first + second + third + fourth
        self.init(result)
    }
}
