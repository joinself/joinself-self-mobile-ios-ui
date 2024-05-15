//
//  LivenessView.swift
//  SelfUI
//
//  Created by Long Pham on 14/5/24.
//

import SwiftUI

public struct LivenessView: View {
    @ObservedObject var cameraManager = CameraManager()
    
    public init () {}
    
    public var body: some View {
        ZStack {
            CameraPreview(session: cameraManager.session)
                .edgesIgnoringSafeArea(.all)
            // face frame
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                    .aspectRatio(1, contentMode: .fit)
                
                Image("face_frame")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .edgesIgnoringSafeArea(.horizontal)
            }
            .frame(width: 300, height: 300)
            
            Text("Camera Placeholder")
                .foregroundColor(.white)
                .bold()
        }
    }
}

#Preview {
    LivenessView()
}
