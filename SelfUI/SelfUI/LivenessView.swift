//
//  LivenessView.swift
//  SelfUI
//
//  Created by Long Pham on 14/5/24.
//

import SwiftUI
import MLKitFaceDetection

public struct LivenessView: View {
    @State private var image: UIImage?
    @State private var isCameraPresented = false
    
    public init () {}
    
    public var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Tap to take a photo")
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .onTapGesture {
            isCameraPresented = true
        }
        .sheet(isPresented: $isCameraPresented) {
            CameraView(image: $image)
        }
    }
}

#Preview {
    LivenessView()
}
