//
//  LivenessView.swift
//  SelfUI
//
//  Created by Long Pham on 14/5/24.
//

import SwiftUI

enum Challenge: String {
    case None,
         Done,
         Smile,
         Blink,
         TurnLeft,
         TurnRight,
         LookUp,
         LookDown
}

public struct LivenessView: View {
    @ObservedObject var viewModel = LivenessOverlayViewModel(text: "", tipImageName: "", isHighlighted: false)
    
    
    public init () {
    }
    
    public var body: some View {
        ZStack {
//            CameraOvelayView(isHighlighted: viewModel.isHighlighted)
            GeometryReader { geometry in
                Image(viewModel.isHighlighted ? "selfie_overlay_highlight" : "selfie_overlay_normal" , bundle: mainBundle)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
//                    .onTapGesture {
//                        self.isHighlighted.toggle() // test code
//                    }
            }
            
            VStack {
                Spacer()
//                TipsSelfie(tipImageName: viewModel.tipImageName, tipDescription: viewModel.text)
                ZStack {
                    Image(viewModel.tipImageName, bundle: mainBundle)
                    Text(viewModel.text)
                        .font(Font.custom("Barlow", size: 25).weight(.bold))
                        .foregroundColor(.black)
                        .offset(x: 0, y: 0)
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    public func onChallengeChanged(challenge: String) {
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
            challengeText = "Look left and back"//"selfie_look_left".localized
        case .TurnRight:
            tipImageName = "bg_turn_right"
            challengeText = "Look right and back"//"selfie_look_right".localized
        case .LookUp:
            tipImageName = "bg_lookup"
            challengeText = "Look up and back"//"selfie_look_up".localized
        case .LookDown:
            tipImageName = "bg_lookdown"
            challengeText = "Look down and back"//"selfie_look_down".localized
            
        default:
            print("Not support challenge: \(state)")
            break
        }
        
        if viewModel.state !=  state {
            if viewModel.state != .None {
                viewModel.isHighlighted = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    viewModel.isHighlighted = false
                    viewModel.tipImageName = tipImageName
                    viewModel.state = state
                    viewModel.text = challengeText
                })
            } else {
                viewModel.tipImageName = tipImageName
                viewModel.state = state
                viewModel.text = challengeText
            }
            
        }
        
    }
}

#Preview {
    LivenessView()
}
