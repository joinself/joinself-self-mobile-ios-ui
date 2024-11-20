//
//  DocumentCameraView.swift
//  SelfUI
//
//  Created by Long Pham on 20/11/24.
//
import SwiftUI

public struct DocumentCameraView: View {
    @ObservedObject var cameraManager = CameraManager()
        
    public init(onResult: ((MRZInfo?) -> Void)? = nil) {
        cameraManager.onResult = onResult
    }
    
    public var body: some View {
        VStack {
            ZStack {
                // Base view with overlay
                Color.black.ignoresSafeArea()
                CameraPreview(session: cameraManager.session)
                .edgesIgnoringSafeArea(.all)
            }.ignoresSafeArea(.all)
        }
        .onAppear(perform: {
            DispatchQueue.global(qos: .background).async {
                self.cameraManager.session.startRunning()
            }
        })
        .onDisappear(perform: {
            print("Camera View disappear.")
            self.cameraManager.session.stopRunning()
        })
    }
}
