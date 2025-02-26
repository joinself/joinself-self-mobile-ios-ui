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
//    @State private var showCheckingView: Bool = false
    @State private var showFailedView: Bool = false
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
                    showLivenessCamera = true
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
                .fullScreenCover(isPresented: $showLivenessCamera) {
                    
                } content: {
                    NewLivenessCameraView(viewModel: viewModel)
                    .transition(.opacity)
                }
                .onChange(of: viewModel.isHighlighted) { newValue in
                    print("Try to hide camera view")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        showLivenessCamera = false
//                        showCheckingView = true
                        viewModel.showVerifyingView = true
                    })
                }
                .onChange(of: viewModel.attemptNumber) { newValue in
//                    showCheckingView = false
                    viewModel.showVerifyingView = false
                    showFailedView = true
                }
                .fullScreenCover(isPresented: $viewModel.showVerifyingView) {
                    
                } content: {
                    LoadingView(message: "checking_your_image".localized)
                }
                .fullScreenCover(isPresented: $showFailedView) {
                    
                } content: {
                    LivenessVerificationFailedView(remainingRetryNumber: viewModel.attemptNumber) {
                        viewModel.isHighlighted = false
                        viewModel.state = .None
                        showFailedView = false
                        showLivenessCamera = true
                    } onNavigationBack: {
                        presentationMode.wrappedValue.dismiss()
                    }

                }

            }
        } else {
            NewLivenessCameraView(viewModel: viewModel)
                .onChange(of: viewModel.isHighlighted) { newValue in
                    print("Try to hide camera view")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        showLivenessCamera = false
//                        showCheckingView = true
                        viewModel.showVerifyingView = true
                    })
                }
                .onChange(of: viewModel.attemptNumber) { newValue in
//                    showCheckingView = false
                    viewModel.showVerifyingView = false
                    showFailedView = true
                }
                .fullScreenCover(isPresented: $viewModel.showVerifyingView) {
                    
                } content: {
                    LoadingView(message: "checking_your_image".localized)
                }
                .fullScreenCover(isPresented: $showFailedView) {
                    
                } content: {
                    LivenessVerificationFailedView(remainingRetryNumber: viewModel.attemptNumber) {
                        viewModel.isHighlighted = false
                        viewModel.state = .None
                        showFailedView = false
                        showLivenessCamera = true
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
