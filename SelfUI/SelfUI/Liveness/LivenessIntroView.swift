//
//  LivenessIntroductionView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI
import AVFoundation

public struct LivenessIntroView: View {
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
        BaseProgressView (totalSteps: 5, activeStep: activeStep, content: {
            VStack (spacing: 30) {
                Text(title)
                    .modifier(Heading3TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Text(subtitle)
                    .modifier(Body1TextStyle())
                Spacer()
            }
            ButtonView(title: "button_start".localized) {
                checkCameraPermission { isGranted in
                    if isGranted {
                        onGettingStarted()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("\(self.getAppName()) Would Like to Access the Camera"),
                    message: Text("Turning on the camera allows us to ensure it's only you using \(self.getAppName())"),
                    primaryButton: .default(Text("Settings")) {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }) {
            self.onNavigationBack()
        }
    }
    
    private func checkCameraPermission(completion: ((Bool) -> Void)? = nil) {
        AVCaptureDevice.requestAccess(for: .video) { authorized in
            Task { @MainActor in
                self.showAlert = !authorized
                completion?(authorized)
            }
        }
    }
    
    private func getAppName() -> String {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
                      Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String

        return appName ?? ""
    }
}

#Preview {
    LivenessIntroView(activeStep: 2) {
        
    } onNavigationBack: {
        
    }

}
