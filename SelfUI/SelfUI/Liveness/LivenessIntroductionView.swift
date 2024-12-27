//
//  LivenessIntroductionView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI
import AVFoundation

public struct LivenessIntroductionView: View {
    @State private var isCameraAuthorized = false
    @Environment(\.presentationMode) var presentationMode
    
    public init(onGettingStarted: @escaping () -> Void, onNavigationBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigationBack = onNavigationBack
    }
    
    var onGettingStarted: () -> Void
    var onNavigationBack: () -> Void
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 1, content: {
            ScrollView {
                Text("title_liveness_check".localized)
                    .font(.defaultTitle)
                    .foregroundColor(.textPrimary)
                    .frame(maxHeight: .infinity)
                
                Spacer(minLength: 30)
                Text("msg_liveness_check".localized)
                    .font(.defaultBody)
                    .lineSpacing(1.18)
                    .foregroundColor(.textPrimary)
            }
            ButtonView(title: "button_start".localized) {
                onGettingStarted()
            }
        })
    }
    
    private func checkCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { authorized in
            DispatchQueue.main.async {
                self.isCameraAuthorized = authorized
            }
        }
    }
}

struct ContentViewView_Previews: PreviewProvider {

    static var previews: some View {
        ForEach(["en", "de"], id: \.self) { id in
            LivenessIntroductionView {
            } onNavigationBack: {
                
            }
                .environment(\.locale, .init(identifier: id))
        }
    }
}
