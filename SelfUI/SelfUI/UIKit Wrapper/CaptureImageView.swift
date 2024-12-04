//
//  CaptureImageView.swift
//  SelfUI
//
//  Created by Long Pham on 29/11/24.
//

import SwiftUI

public struct CaptureImageView: View {
    @State private var isShowingCamera = false
    @State private var capturedImage: UIImage?
    @State private var descriptionText = ""
    
    private var onCapture: ((UIImage, String?) -> Void)?
    public init(onCapture: ((UIImage, String?) -> Void)? = nil) {
        self.onCapture = onCapture
    }
    
    public var body: some View {
        CameraView(image: $capturedImage)
            .onChange(of: self.capturedImage ?? UIImage()) { newValue in
                self.capturedImage = newValue
                print("New image: \(newValue)")
                onCapture?(newValue, nil)
            }
    }
}

#Preview {
    CaptureImageView()
}
