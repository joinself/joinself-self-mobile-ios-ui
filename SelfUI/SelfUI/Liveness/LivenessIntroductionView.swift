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
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Set the background
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    NavBackButton {
                        onNavigationBack()
                    }.padding()
                }.padding(.leading, 20)
                
                // stepped progress view
                VStack(alignment: .center) {
                    CustomProgressView(steps: [
                        Step(title: "1", state: .done),
                        Step(title: "2", state: .done),
                        Step(title: "3", state: .done),
                        Step(title: "4", state: .active),
                        Step(title: "5", state: .inactive)
                    ])
                }.frame(maxWidth: .infinity)
                
                Spacer(minLength: 50)
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("Take a selfie".localized)
                        .font(.defaultTitle)
                        .foregroundColor(.black)
                    Text("Take a selfie description".localized)
                        .font(.defaultBody)
                        .lineSpacing(1.18)
                        .foregroundColor(.textPrimary)
                    Spacer()
                }
                .padding(EdgeInsets(top: 50, leading: 24, bottom: 10, trailing: 24))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
                VStack(spacing: 12) {
                    ButtonView(title: "Start".localized) {
                        onGettingStarted()
                    }
                    
                    BrandView(isDarked: true)
                }.padding()
            }
            .background(.white)
            .navigationBarBackButtonHidden(true)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image("ic_back_dark", bundle: mainBundle)
                        }
                    }
                }
            }
        }
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
