//
//  LivenessCameraView.swift
//  SelfUI
//
//  Created by Long Pham on 20/5/24.
//

import SwiftUI
import AVFoundation

public struct LivenessCameraView: View {
    @ObservedObject var viewModel = LivenessOverlayViewModel(text: "", tipImageName: "ic_transparent", isHighlighted: false)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) var dismiss
    
    public var onNavigateBack: () -> Void
    public var onAppeared: (() -> Void)? = nil
    @ObservedObject var cameraManager = CameraManager(cameraPosition: .front)
    @Binding private var faceChallenge: String
    @Binding private var isPassed: Bool
    
    public init(faceChallenge: Binding<String> = .constant(""), isPassed: Binding<Bool> = .constant(false), onAppeared: (() -> Void)? = nil, onCapture: ((CMSampleBuffer) -> Void)? = nil, onNavigateBack: @escaping () -> Void) {
        self.onNavigateBack = onNavigateBack
        self.onAppeared = onAppeared
        self._faceChallenge = faceChallenge
        self._isPassed = isPassed
        cameraManager.onCapture = onCapture
        
        self.onChallengeChanged(challenge: faceChallenge.wrappedValue, isPassed: isPassed.wrappedValue)
    }
    
    public var body: some View {
        ZStack {
            CameraPreview(session: cameraManager.session)
            
            GeometryReader { geometry in
                Image(viewModel.isHighlighted ? "selfie_overlay_highlight" : "selfie_overlay_normal" , bundle: mainBundle)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack (alignment: .center) {
                Spacer()
                ZStack {
                    Image(viewModel.tipImageName, bundle: mainBundle)
                    Text(viewModel.text)
                        .font(Font.custom("Barlow", size: 25).weight(.bold))
                        .foregroundColor(.black)
                }
                //.offset(x: 0, y: -80)
                
                BrandView(isDarked: false)
                    .padding(.bottom, 24)
            }
            
            VStack (alignment: .leading) {
                VStack(content: {
                }).frame(height: 24)
                
                HStack {
                    Image("ic_back", bundle: mainBundle)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .onTapGesture {
                            onNavigateBack()
                        }
                    Spacer()
                }.padding()
                Spacer()
            }.padding()
        }
        .onAppear(perform: {
            DispatchQueue.global(qos: .background).async {
                self.cameraManager.session.startRunning()
            }
        })
        .onDisappear(perform: {
            print("Camera View disappear.")
            self.cameraManager.session.stopRunning()
        })
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
    LivenessCameraView {
        
    }
}
