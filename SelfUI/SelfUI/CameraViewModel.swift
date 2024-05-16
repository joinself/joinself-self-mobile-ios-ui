//
//  CameraViewModel.swift
//  SelfUI
//
//  Created by Long Pham on 16/5/24.
//

import AVFoundation
import MLKit
import MLImage

class CameraViewModel: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    @Published var detectedFaces: [FaceModel] = []
    private let faceDetector = FaceDetector.faceDetector(options: FaceDetectorOptions())
    
    // Setup the camera
    func setupCamera() {
        // Camera setup code goes here
    }
    
    // AVCaptureVideoDataOutputSampleBufferDelegate method
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Get image from sample buffer
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let visionImage = VisionImage(buffer: sampleBuffer)
        visionImage.orientation = imageOrientation(
            deviceOrientation: UIDevice.current.orientation,
            cameraPosition: .front
        )
        
        // Detect faces
        faceDetector.process(visionImage) { faces, error in
            guard error == nil, let faces = faces, !faces.isEmpty else {
                // Handle error or no faces detected
                return
            }
            
            // Update detectedFaces
            self.detectedFaces = faces.map { FaceModel(frame: $0.frame) }
        }
    }
    
    // Helper function to convert device orientation to image orientation
    private func imageOrientation(
        deviceOrientation: UIDeviceOrientation,
        cameraPosition: AVCaptureDevice.Position
    ) -> UIImage.Orientation {
        // Conversion logic goes here
        let orientation = UIUtilities.imageOrientation(
            fromDevicePosition: cameraPosition
        )
        
        return orientation
    }
}
