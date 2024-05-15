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
        VStack {
            CameraPreview(session: cameraManager.session)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    LivenessView()
}
