//
//  LivenessIntroductionView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI
import AVFoundation

struct LivenessIntroductionView: View {
    @State private var isStarted = false
    @State private var isCameraAuthorized = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isLinkActive = false
    @State private var path: [Color] = []
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image("ic_back_dark", bundle: mainBundle) // Replace with your image name
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 64, leading: 24, bottom: 0, trailing: 15))
                .onTapGesture {
                    dismiss()
                }
            
            // stepped progress view
            ZStack() {
                SteppedProgressView(totalSteps: 5, currentStep: 1, progressColor: .green, backgroundColor: .gray)
            }
            
            VStack(alignment: .leading, spacing: 30) {
                Text("Take a selfie".localized)
                    .font(.system(size: 36).weight(.bold))
                    .foregroundColor(.black)
                Text("Take a selfie description".localized)
                    .font(.appFont(fontName: .sfPro, size: 17).weight(.bold))
                    .lineSpacing(1.18)
                    .foregroundColor(.black)
            }
            .padding(EdgeInsets(top: 100, leading: 15, bottom: 10, trailing: 15))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
            VStack(spacing: 0) {
                Button(action: {
                    self.checkCameraPermission()
                }, label: {
                    ButtonView()
                }).navigationDestination(isPresented: $isCameraAuthorized, destination: {
                    LivenessView()
                })
                BrandView()
            }
        }
        .ignoresSafeArea(.all)
        
    }
    
    private func checkCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { authorized in
            DispatchQueue.main.async {
                self.isCameraAuthorized = authorized
                self.isStarted = authorized
            }
        }
    }
}

struct ContentViewView_Previews: PreviewProvider {

    static var previews: some View {
        ForEach(["en", "de"], id: \.self) { id in
            LivenessIntroductionView()
                .environment(\.locale, .init(identifier: id))
        }
    }
}
