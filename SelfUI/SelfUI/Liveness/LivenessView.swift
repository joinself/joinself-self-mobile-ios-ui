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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) var dismiss
    
    public var onNavigateBack: () -> Void
    
    public init(onNavigateBack: @escaping () -> Void) {
        self.onNavigateBack = onNavigateBack
    }
    
    public var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image(viewModel.isHighlighted ? "selfie_overlay_highlight" : "selfie_overlay_normal" , bundle: mainBundle)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack {
                Spacer()
                ZStack {
                    Image(viewModel.tipImageName, bundle: mainBundle)
                    Text(viewModel.text)
                        .font(Font.custom("Barlow", size: 25).weight(.bold))
                        .foregroundColor(.black)
                }.offset(x: 0, y: -80)
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
        .edgesIgnoringSafeArea(.all)
    }
    
    public func onChallengeChanged(challenge: String, isPassed: Bool) {
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
    LivenessView {
        
    }
}
