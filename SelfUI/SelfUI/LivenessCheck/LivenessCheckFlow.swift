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
    let showLivenessCheckIntroduction: Bool
    
    @ObservedObject private var viewModel: LivenessCheckViewModel
    
    public init(viewModel: LivenessCheckViewModel, showLivenessCheckIntroduction: Bool = true) {
        self.viewModel = viewModel
        self.showLivenessCheckIntroduction = showLivenessCheckIntroduction
    }
    
    public var body: some View {
        if showLivenessCheckIntroduction {
            NavigationStack(path: $path) {
                LivenessIntroductionView {
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
        } else {
            NewLivenessCameraView(viewModel: viewModel)
        }
    }
}

#Preview {
    LivenessCheckFlow(viewModel: LivenessCheckViewModel(text: "", tipImageName: "", isHighlighted: false), showLivenessCheckIntroduction: false)
}
