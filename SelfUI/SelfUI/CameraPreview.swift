//
//  CameraPreview.swift
//  SelfUI
//
//  Created by Long Pham on 15/5/24.
//

import SwiftUI
import AVFoundation
//import MLKitVision
//import MLKitFaceDetection

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
//    private let faceDetector = FaceDetector.faceDetector()
    
    override init() {
        super.init()
        
        Task {
            await self.setupCamera()
        }
        
    }
    
    private func setupCamera() async {
        // Ensure the device has a camera
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        
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
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        detectFaces(sampleBuffer: sampleBuffer)
    }
}

