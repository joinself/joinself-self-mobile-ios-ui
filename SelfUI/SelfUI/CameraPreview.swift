//
//  CameraPreview.swift
//  SelfUI
//
//  Created by Long Pham on 15/5/24.
//

import SwiftUI
import AVFoundation
import Vision

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

class CameraManager: NSObject, ObservableObject {
    let session = AVCaptureSession()
    private let output = AVCaptureVideoDataOutput()

    @Published var isValidMRZ: Bool = false
    var onResult: ((MRZInfo?) -> Void)? = nil
    
    override init() {
        super.init()
        
        Task {
            await self.setupCamera()
        }
        
    }
    
    private func setupCamera() async {
        // Ensure the device has a camera
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
        
        do {
            // Setup input and output
            let input = try AVCaptureDeviceInput(device: camera)
            session.addInput(input)
            session.addOutput(output)
            
            // Configure the output
            output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            session.startRunning()
        } catch {
            print("Failed to setup camera: \(error)")
        }
    }
    
    func detectFaces(sampleBuffer: CMSampleBuffer) {
        print("Face detecting.... ")
        
//        let visionImage = VisionImage(buffer: sampleBuffer)
//        visionImage.orientation = .up
//        
//        faceDetector.process(visionImage) { faces, error in
//            guard error == nil, let faces = faces else {
//                print("Face detection failed with error: \(error?.localizedDescription ?? "")")
//                return
//            }
//            // Handle detected faces
//            for face in faces {
//                // Example: Get the frame of the face
//                let frame = face.frame
//                print("Detected face frame: \(frame)")
//            }
//        }
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
            
            let result = recognizedStrings.joined().formatFromMRZLine()
            print("Expected mrz: \(mrzLines)")
            
            if let mrzInfo = OcrUtils.parseMRZInfo(mrzString: mrzLines) {
                print("Expected mrzInfo: \(mrzInfo)")
                DispatchQueue.main.async {
                    self.isValidMRZ = mrzInfo.isvalidMZR()
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
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        detectFaces(sampleBuffer: sampleBuffer)
        self.detectPassportMRZ(sampleBuffer: sampleBuffer)
    }
}

