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
    let showLivenessCheckIntroduction: Bool
    
    @ObservedObject private var viewModel: LivenessCheckViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(viewModel: LivenessCheckViewModel, showLivenessCheckIntroduction: Bool = true) {
        self.viewModel = viewModel
        self.showLivenessCheckIntroduction = showLivenessCheckIntroduction
    }
    
    public var body: some View {
        if showLivenessCheckIntroduction {
            NavigationStack(path: $path) {
                LivenessIntroductionView(title: viewModel.title, subtitle: viewModel.subtitle) {
                    viewModel.showLivenessCamera = true
                } onNavigationBack: {
                    presentationMode.wrappedValue.dismiss()
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
                .fullScreenCover(isPresented: $viewModel.showLivenessCamera) {
                    
                } content: {
                    NewLivenessCameraView(viewModel: viewModel)
                    .transition(.opacity)
                }
                .fullScreenCover(isPresented: $viewModel.showVerifyingView) {
                    
                } content: {
                    LoadingView(message: "checking_your_image".localized)
                        .transition(.opacity)
                }
                .transition(.opacity)
                .fullScreenCover(isPresented: $viewModel.showFailedView) {
                    
                } content: {
                    LivenessVerificationFailedView(remainingRetryNumber: viewModel.attemptNumber) {
                        viewModel.retry()
                    } onNavigationBack: {
                        presentationMode.wrappedValue.dismiss()
                    }

                }

            }
        } else {
            NewLivenessCameraView(viewModel: viewModel)
                .fullScreenCover(isPresented: $viewModel.showVerifyingView) {
                    
                } content: {
                    LoadingView(message: "checking_your_image".localized)
                        .transition(.opacity)
                }
                .transition(.opacity)
                .fullScreenCover(isPresented: $viewModel.showFailedView) {
                    
                } content: {
                    LivenessVerificationFailedView(remainingRetryNumber: viewModel.attemptNumber) {
                        viewModel.retry()
                    } onNavigationBack: {
                        presentationMode.wrappedValue.dismiss()
                    }

                }
        }
    }
}

#Preview {
    LivenessCheckFlow(viewModel: LivenessCheckViewModel(text: "", tipImageName: "", isHighlighted: false), showLivenessCheckIntroduction: true)
}
