//
//  LivenessIntroductionView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI
import AVFoundation

public struct LivenessIntroductionView: View {
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    let title: String
    let subtitle: String
    let activeStep: Int
    
    public init(title: String = "title_liveness_check".localized, subtitle: String = "msg_liveness_check".localized, activeStep: Int = 1, onGettingStarted: @escaping () -> Void, onNavigationBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigationBack = onNavigationBack
        self.title = title
        self.subtitle = subtitle
        self.activeStep = activeStep
    }
    
    var onGettingStarted: () -> Void
    var onNavigationBack: () -> Void
    
    public var body: some View {
        NavigationView(content: {
            BaseProgressView (totalSteps: 5, activeStep: activeStep, content: {
                ScrollView {
                    Text(title)
                        .font(.defaultTitle)
                        .foregroundColor(.textPrimary)
                        .frame(maxHeight: .infinity)
                    
                    Spacer(minLength: 30)
                    Text(subtitle)
                        .font(.defaultBody)
                        .lineSpacing(1.18)
                        .foregroundColor(.textPrimary)
                }
                .padding(0)
                ButtonView(title: "button_start".localized) {
                    checkCameraPermission { isGranted in
                        if isGranted {
                            onGettingStarted()
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Camera Permission Required"),
                        message: Text("Please enable camera access in Settings."),
                        primaryButton: .default(Text("Settings")) {
                            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            })
        })
        //.navigationBarHidden(true)
    }
    
    private func checkCameraPermission(completion: ((Bool) -> Void)? = nil) {
        AVCaptureDevice.requestAccess(for: .video) { authorized in
            Task { @MainActor in
                self.showAlert = !authorized
                completion?(authorized)
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
