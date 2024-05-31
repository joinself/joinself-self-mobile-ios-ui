//
//  PassportMRZView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

class PassportMRZViewModel: ObservableObject {
    @Published var isHighlighted: Bool = false
}

public struct PassportMRZView: View {
    @ObservedObject var viewModel = PassportMRZViewModel()
    @ObservedObject var cameraManager = CameraManager()
    
    public var onResult: ((String?) -> Void)? = nil
    public init(onResult: ((String?) -> Void)? = nil) {
        self.onResult = onResult
    }
    
    public var body: some View {
        ZStack {
            // Base view with overlay
            Color.black.ignoresSafeArea()
            CameraPreview(session: cameraManager.session)
            .edgesIgnoringSafeArea(.all)
            MRZOverlayView(isHighlighted: !cameraManager.mrzKey.isEmpty)
        }.ignoresSafeArea(.all)
    }
}

#Preview {
    PassportMRZView()
}
