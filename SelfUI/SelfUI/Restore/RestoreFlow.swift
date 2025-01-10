//
//  RestoreFlow.swift
//  SelfUI
//
//  Created by Long Pham on 5/12/24.
//

import SwiftUI
import Combine

public class RestoreFlowViewModel: ObservableObject {
    @Published public var isRestored: Bool = false
    @Published public var isRestoring: Bool = false
    @Published public var destination: [RestoreDestinations] = []
    public init() {
    }
}

public enum RestoreDestinations: String, CaseIterable, Hashable {
    case Info
    case LivenessCaptureIntroduction
    case Restoring
    case Done
}

public struct RestoreFlow: View, BaseActions {
    var onNext: (() -> Void)?
    var onDone: (() -> Void)?
    @Binding var isNetworkConnected: Bool
    @State private var path: [RestoreDestinations] = [RestoreDestinations]()
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var viewModel: RestoreFlowViewModel
    
    public init(viewModel: RestoreFlowViewModel = RestoreFlowViewModel(), isNetworkConnected: Binding<Bool> = .constant(true),
                onNext: (() -> Void)? = nil) {
        self.onNext = onNext
        _viewModel = StateObject(wrappedValue: viewModel)
        self._isNetworkConnected = isNetworkConnected
    }
    
    public var body: some View {
        VStack {
            if !isNetworkConnected {
                BannerView(message: "no_internet_connection".localized)
            }
            
            NavigationStack(path: $viewModel.destination) {
                RestoreIntroView {
//                    onNext?()
                    viewModel.destination = [.LivenessCaptureIntroduction]
//                    path = [.Restoring]
                }
                .navigationDestination(for: RestoreDestinations.self) { destination in
                    
                    switch destination {
                    case .Info:
                        Text("Backup")
                        
                    case .Restoring:
                        RestoringBackupView {
                            
                        }
//                        .onAppear {
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////                                viewModel.isRestored = true
//                                viewModel.destination = [.Done]
//                            }
//                        }
                        
                    case .LivenessCaptureIntroduction:
                        LivenessIntroductionView (title: "title_liveness_capture".localized, subtitle: "msg_liveness_capture".localized, activeStep: 2) {
                            onNext?()
                        } onNavigationBack: {
                            
                        }
                        
                    case .Done:
                        RestoringBackupFinishView {
                            onDone?()
                        }
                    }
                }
            }
            .onChange(of: viewModel.isRestored) { newValue in
                path = [.Done]
            }
            
            Spacer()
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    VStack {
        RestoreFlow(isNetworkConnected: .constant(false))
    }
    
}
