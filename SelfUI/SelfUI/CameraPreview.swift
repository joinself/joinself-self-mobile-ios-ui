//
//  CameraPreview.swift
//  SelfUI
//
//  Created by Long Pham on 15/5/24.
//

import SwiftUI
import AVFoundation
import Vision
import Combine

struct CameraPreview: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {}
}

public enum CaptureMode : Int, CaseIterable {
    case undefined = 0
    case detectPassportMRZ = 1
    case detectIDCardMRZ = 2
    case detectQRCode = 3
    case captureFrontPage = 4
    case captureBackPage = 5
    case captureLiveImage = 6
}

public class CameraManager: NSObject, ObservableObject {
    let session = AVCaptureSession()
    private let output = AVCaptureVideoDataOutput()
    private var cameraPosition: AVCaptureDevice.Position = .back
    @Published var isHighlighted: Bool = false
    var onResult: ((MRZInfo?) -> Void)? = nil
    var onCapture: ((CMSampleBuffer) -> Void)? = nil
    public var capturePublisher = PassthroughSubject<CMSampleBuffer?, Never>()
    
    var captureMode: CaptureMode = .detectPassportMRZ
    @Published var detectedRectangles: [VNRectangleObservation] = []
    @Published var image: UIImage?
    @Published var croppedImage: UIImage?
    
    override init() {
        super.init()
        
        self.initCamera()
    }
    
    public init(cameraPosition: AVCaptureDevice.Position = .back, captureMode: CaptureMode = .detectPassportMRZ) {
        super.init()
        
        self.captureMode = captureMode
        self.cameraPosition = cameraPosition
        self.initCamera()
    }
    
    private func initCamera() {
        Task {
            await self.setupCamera()
        }
    }
    
    private func setupCamera() async {
        // Ensure the device has a camera
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition) else { return }
        
        do {
            // Setup input and output
            let input = try AVCaptureDeviceInput(device: camera)
            session.addInput(input)
            
            // Configure the output
            
            session.sessionPreset = AVCaptureSession.Preset.high
            
            if cameraPosition == .front /*liveness check*/ {
                output.videoSettings = [
                    (kCVPixelBufferPixelFormatTypeKey as String): kCVPixelFormatType_32BGRA
                ]
                output.alwaysDiscardsLateVideoFrames = true
            }
            
            session.addOutput(output)
            session.commitConfiguration()
            output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            //            session.startRunning()
        } catch {
            print("Failed to setup camera: \(error)")
        }
    }
    
    func detectPassportMRZ(sampleBuffer: CMSampleBuffer) {
        print("Detect passport mrz.")
        guard let image = self.imageFromSampleBuffer(sampleBuffer: sampleBuffer) else {
            print("Can't convert sample buffer to image.")
            return
        }
        // process image
        self.processPassportImage(passportImage: image)
    }
    
    func processPassportImage(passportImage: UIImage) {
        // Replace with the actual image of the passport page
        //        guard let passportImage = UIImage(named: "passportPage") else { return }
        let cgImage = passportImage.cgImage!
        
        // Create a Vision request to recognize text
        let textRecognitionRequest = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            // Process the recognized text
            let recognizedStrings = observations.compactMap { observation in
                // Return the top candidate's string
                observation.topCandidates(1).first?.string
            }
            
            print("Recognized text: \(recognizedStrings)")
            
            // Filter out non-MRZ text and join the MRZ lines
            let recognizedText = recognizedStrings
                .filter { $0.count >= 44 } // MRZ lines are typically at least 44 characters
                .joined(separator: "\n")
            
            print("MRZ: \(recognizedText)")
            
            let mrzLines = recognizedStrings.filter { s in
                s.contains("<")
            }.joined().formatFromMRZLine()
            
            print("Expected mrz: \(mrzLines)")
            
            if let mrzInfo = OcrUtils.parseMRZInfo(mrzString: mrzLines), mrzInfo.isvalidMZR() {
                print("Expected mrzInfo: \(mrzInfo)")
                DispatchQueue.main.async {
                    self.isHighlighted = mrzInfo.isvalidMZR()
                    Utils.vibrate()
                    self.onResult?(mrzInfo)
                }
                self.session.stopRunning()
            }
            
        }
        
        // Set the recognition level to accurate for MRZ scanning
        textRecognitionRequest.recognitionLevel = .accurate
        
        // Perform the text recognition request
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        try? requestHandler.perform([textRecognitionRequest])
    }
    
    private func detectIDCardMRZ(sampleBuffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        guard let image = self.imageFromSampleBuffer(sampleBuffer: sampleBuffer) else {
            print("Can't convert sample buffer to image.")
            return
        }
        
        // Create a Vision request to recognize text
        let textRecognitionRequest = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            // Process the recognized text
            let recognizedStrings = observations.compactMap { observation in
                // Return the top candidate's string
                observation.topCandidates(1).first?.string
            }
            
            print("Recognized text: \(recognizedStrings)")
            
            // Filter out non-MRZ text and join the MRZ lines
            let recognizedText = recognizedStrings
                .filter { $0.count >= 30 && $0.contains("<") } // MRZ lines are typically at least 30 characters
                .joined(separator: "\n")
            
            print("MRZ: \(recognizedText)")
            
            let mrzLines = recognizedStrings.filter { s in
                s.contains("<")
            }.map { s in
                s.formatIDCardMRZLine()
            }
            
            print("Expected mrz: \(mrzLines)")
            
            if self.isValidMRZ(mrzLines: mrzLines) {
                DispatchQueue.main.async {
                    self.isHighlighted = true
                    self.image = image
                    self.croppedImage = image
                    self.session.stopRunning()
                }
            }
        }
        
        // Set the recognition level to accurate for MRZ scanning
        textRecognitionRequest.recognitionLevel = .accurate
        
        // Perform the text recognition request
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        try? requestHandler.perform([textRecognitionRequest])
    }
    
    private func detectTexts(sampleBuffer: CMSampleBuffer, completion: (([String]) -> Void)? = nil) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        // Create a Vision request to recognize text
        let textRecognitionRequest = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            // Process the recognized text
            let recognizedStrings = observations.compactMap { observation in
                // Return the top candidate's string
                observation.topCandidates(1).first?.string
            }
            
            print("Recognized text: \(recognizedStrings)")
            completion?(recognizedStrings)
        }
        
        // Set the recognition level to accurate for MRZ scanning
        textRecognitionRequest.recognitionLevel = .accurate
        
        // Perform the text recognition request
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        try? requestHandler.perform([textRecognitionRequest])
    }
    
    func isValidMRZ(mrzLines: [String]) -> Bool {
        if mrzLines.count != 3 {
            return false
        }
        let line1 = mrzLines[0]
        let line2 = mrzLines[1]
        let _ = mrzLines[2]
        let valid = line1.count == 30 && line2.count == 30
        print("isValidMRZ: \(valid)")
        return valid
    }
    
    private func handleCardBuffer(sampleBuffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        guard let image = self.imageFromSampleBuffer(sampleBuffer: sampleBuffer) else {
            print("Can't convert sample buffer to image.")
            return
        }
        
        let request = VNDetectRectanglesRequest { (request, error) in
            if let firstResult = request.results?.first as? VNRectangleObservation {   
                self.detectTexts(sampleBuffer: sampleBuffer) { recognizedTexts in
                    if recognizedTexts.count > 0 {
                        print("Detected card at: \(firstResult.boundingBox)")
                        Task { @MainActor in
                            self.isHighlighted = true
                            self.image = image
                            self.croppedImage = self.cropImage(image: image, observation: firstResult)
                            self.session.stopRunning()
                        }
                    }
                }
            }
        }
        
        //Set the value for the detected rectangle
        request.minimumAspectRatio = 0.5 // Adjust based on ID card dimensions
        request.maximumAspectRatio = 1.0 // Adjust based on ID card dimensions
        request.quadratureTolerance = 10.0 // Allow some deviation from 90 degrees
        request.minimumSize = 0.5 // Minimum size of the rectangle as a proportion of the smallest dimension
        request.minimumConfidence = 0.8 // Minimum confidence level for detection
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        try? handler.perform([request])
        
    }
    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage? {
        // Get the image buffer from the sample buffer
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }
        
        // Lock the base address of the pixel buffer
        CVPixelBufferLockBaseAddress(imageBuffer, .readOnly)
        
        // Create a Core Image from the pixel buffer
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        
        // Unlock the pixel buffer
        CVPixelBufferUnlockBaseAddress(imageBuffer, .readOnly)
        
        // Create a context to convert the CIImage to a CGImage
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        
        // Create a UIImage from the CGImage
        let uiImage = UIImage(cgImage: cgImage)
        
        return uiImage
    }
    
    private func cropImage(image: UIImage, observation: VNRectangleObservation) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        let width = CGFloat(cgImage.width)
        let height = CGFloat(cgImage.height)
        
        let boundingBox = observation.boundingBox
        let x = boundingBox.origin.x * width
        let y = (1 - boundingBox.origin.y - boundingBox.height) * height
        let rect = CGRect(x: x, y: y, width: boundingBox.width * width, height: boundingBox.height * height)
        
        guard let croppedCGImage = cgImage.cropping(to: rect) else { return nil }
        return UIImage(cgImage: croppedCGImage)
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if captureMode == .captureFrontPage || captureMode == .captureBackPage {
            self.handleCardBuffer(sampleBuffer: sampleBuffer)
            return
        } else if captureMode == .detectIDCardMRZ {
            self.detectIDCardMRZ(sampleBuffer: sampleBuffer)
            return
        } else if captureMode == .captureLiveImage {
            DispatchQueue.main.async {
                self.capturePublisher.send(sampleBuffer)
            }
            
            return
        }
        
        if let onCapture = onCapture {
            onCapture(sampleBuffer)
        } else {
            self.detectPassportMRZ(sampleBuffer: sampleBuffer)
        }
    }
}

