//
//  LivenessCameraView.swift
//  SelfUI
//
//  Created by Long Pham on 20/5/24.
//

import SwiftUI
import AVFoundation

public struct NewLivenessCameraView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject private var viewModel: LivenessCheckViewModel
    private var onBack: (() -> Void)? = nil
    
    public init(viewModel: LivenessCheckViewModel, onBack: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.onBack = onBack
    }
    
    public var body: some View {
        ZStack {
            CameraPreview(session: viewModel.cameraManager.session)
            
            SelfieOverlayView(isHighlighted: $viewModel.isHighlighted)
            
            VStack (alignment: .center) {
                Spacer()
                ZStack {
                    Image(viewModel.tipImageName, bundle: mainBundle)
                    Text(viewModel.text)
                        .font(Font.defaultNormalTitle)
                        .foregroundColor(.textPrimary)
                }
                
                BrandView(isDarked: false, textColor: .white)
                    .padding(.bottom, 24)
                    .hidden()
            }
            
            VStack (alignment: .leading) {
                VStack(content: {
                }).frame(height: 24)
                
                HStack {
                    NavBackButton(isWhiteBackground: true) {
                        print("Tap back......")
                        onBack?()
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }.padding()
                Spacer()
            }.padding()
        }
        .onAppear(perform: {
            self.viewModel.startCamera()
        })
        .onDisappear(perform: {
            print("Camera View disappear.")
            self.viewModel.stopCamera()
        })
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
    
    public func onHighlight(isPassed: Bool) {
        viewModel.isHighlighted = isPassed
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            viewModel.isHighlighted = false
        })
    }
}

#Preview {
    NewLivenessCameraView(viewModel: LivenessCheckViewModel(text: "", tipImageName: "", isHighlighted: false))
}
