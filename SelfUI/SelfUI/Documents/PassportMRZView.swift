//
//  PassportMRZView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

class PassportMRZViewModel: ObservableObject {
    
}

public struct PassportMRZView: View {
    @ObservedObject var viewModel = PassportMRZViewModel()
    @ObservedObject var cameraManager = CameraManager()
    
    public var onResult: ((String?) -> Void)? = nil
    public init() {
        
    }
    
    public var body: some View {
        ZStack {
            // Base view with overlay
            Color.blue.ignoresSafeArea()
            CameraPreview(session: cameraManager.session)
            .edgesIgnoringSafeArea(.all)
            /*Image("mrz_frame", bundle: mainBundle)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 373, height: 252)
                                    .padding()
            TransparentHoleView(holeSize: CGSizeMake(373, 252))
            .background(Color.black.opacity(0.6))
            .ignoresSafeArea()*/
            MRZOverlayView(isHighlighted: false)
//                .background(Color.black.opacity(0.6))
//                .ignoresSafeArea()
        }.ignoresSafeArea(.all)
    }
}

#Preview {
    PassportMRZView()
}
