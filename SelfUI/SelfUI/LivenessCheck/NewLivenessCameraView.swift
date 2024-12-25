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
    
//    @ObservedObject var cameraManager = CameraManager(cameraPosition: .front, captureMode: .captureLiveImage)
    
    @StateObject private var viewModel: LivenessCheckViewModel
    
    public init(viewModel: LivenessCheckViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            CameraPreview(session: viewModel.cameraManager.session)
            
//            Image(viewModel.isHighlighted ? "selfie_overlay_highlight" : "selfie_overlay_normal" , bundle: mainBundle)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
            SelfieOverlayView(isHighlighted: viewModel.isHighlighted)
            
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
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }.padding()
                Spacer()
            }.padding()
        }
        .onChange(of: viewModel.state, perform: { newValue in
            print("State changed: \(newValue)")
            viewModel.cal()
        })
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
    
    public func onChallengeChanged(challenge: String, isPassed: Bool) {
        print("onChallengeChanged")
        guard let state = Challenge(rawValue: challenge) else {
            print("Invalid challenge: \(challenge)")
            return
        }
        
        var tipImageName = ""
        var challengeText = ""
        print("onChallengeChanged: \(state)")
        
        switch state {
        case .TurnLeft:
            tipImageName = "bg_turn_left"
            challengeText = "selfie_look_left".localized
        case .TurnRight:
            tipImageName = "bg_turn_right"
            challengeText = "selfie_look_right".localized
        case .LookUp:
            tipImageName = "bg_lookup"
            challengeText = "selfie_look_up".localized
        case .LookDown:
            tipImageName = "bg_lookdown"
            challengeText = "selfie_look_down".localized
            
        default:
            print("Not support challenge: \(state)")
            tipImageName = "ic_transparent"
            break
        }
        
        if viewModel.state !=  state {
            if viewModel.state != .None {
                DispatchQueue.main.async {
                    viewModel.tipImageName = tipImageName
                    viewModel.state = state
                    viewModel.text = challengeText
                }
            } else {
                viewModel.tipImageName = tipImageName
                viewModel.state = state
                viewModel.text = challengeText
            }
            
        }
        
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
