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
    @Published public var isNetworkConnected: Bool = true
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
                onNext: (() -> Void)? = nil, onDone: (() -> Void)? = nil) {
        self.onNext = onNext
        self.onDone = onDone
        _viewModel = StateObject(wrappedValue: viewModel)
        self._isNetworkConnected = isNetworkConnected
    }
    
    public var body: some View {
        VStack {
            if !viewModel.isNetworkConnected {
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
                        NavigationView(content: {
                            RestoringBackupView {
                                
                            }
                        })
                        .navigationBarHidden(true)
                        
                        
                    case .LivenessCaptureIntroduction:
                        LivenessIntroductionView (title: "title_liveness_capture".localized, subtitle: "msg_liveness_capture".localized, activeStep: 2) {
                            onNext?()
                        } onNavigationBack: {
                            print("navigate back.")
                            presentationMode.wrappedValue.dismiss()
                        }
                        .navigationBarHidden(true)
                        
                    case .Done:
                        NavigationView(content: {
                            RestoringBackupFinishView {
                                onDone?()
                            }
                        })
                        .navigationBarHidden(true)
                    }
                }
            }
            .onChange(of: viewModel.isRestored) { newValue in
                path = [.Done]
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    VStack {
        RestoreFlow(isNetworkConnected: .constant(false))
    }
    
}
