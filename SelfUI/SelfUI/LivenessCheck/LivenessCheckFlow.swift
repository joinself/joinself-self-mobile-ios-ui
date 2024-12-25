//
//  LivenessCheckFlow.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI
import AVFoundation

enum LivenessCheckDestinations: String, CaseIterable, Hashable {
    case Intro
    case LiveCapture
    case Done
}

public struct LivenessCheckFlow: View {
    @State private var path: [LivenessCheckDestinations] = [LivenessCheckDestinations]()
    
    @State private var showLivenessCamera: Bool = false
    
    @StateObject private var viewModel: LivenessCheckViewModel
    
    public init(viewModel: LivenessCheckViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            LivenessIntroductionView {
                print("Liveness....")
                showLivenessCamera = true
            } onNavigationBack: {
                
            }
            .navigationDestination(for: LivenessCheckDestinations.self) { selection in
                switch selection {
                case .LiveCapture:
                    LivenessCameraView {
                        
                    }
                default:
                    Text("Hello")
                }
            }
            .fullScreenCover(isPresented: $showLivenessCamera) {
                
            } content: {
                NewLivenessCameraView(viewModel: viewModel)
                .transition(.opacity)
            }

        }
    }
}

#Preview {
    LivenessCheckFlow(viewModel: LivenessCheckViewModel(text: "", tipImageName: "", isHighlighted: false))
}
