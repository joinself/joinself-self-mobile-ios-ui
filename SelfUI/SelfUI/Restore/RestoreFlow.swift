//
//  RestoreFlow.swift
//  SelfUI
//
//  Created by Long Pham on 5/12/24.
//

import SwiftUI

enum RestoreDestinations: String, CaseIterable, Hashable {
    case Info
    case LivenessCheck
    case Done
}

public struct RestoreFlow: View, BaseActions {
    var onNext: (() -> Void)?
    @Binding var isNetworkConnected: Bool
    @State private var path: [RestoreDestinations] = [RestoreDestinations]()
    @Environment(\.presentationMode) private var presentationMode
    public init(isNetworkConnected: Binding<Bool> = .constant(true),
                onNext: (() -> Void)? = nil) {
        self.onNext = onNext
        self._isNetworkConnected = isNetworkConnected
    }
    
    public var body: some View {
        VStack {
            if !isNetworkConnected {
                BannerView(message: "no_internet_connection".localized)
            }
            
            NavigationStack(path: $path) {
                RestoreIntroView {
                    onNext?()
                    //path = [.LivenessCheck]
                }
                .navigationDestination(for: RestoreDestinations.self) { destination in
                    
                    switch destination {
                    case .Info:
                        Text("Backup")
                        
                    case .LivenessCheck:
                        BackingupView {
                            
                        } onNavigateBack: {
                            
                        }
                        /*.onAppear()
                        {
                            print("Backing up...")
                            // Test
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                backupFinish = true
                                path = [.Done]
                            }
                        }*/
                        
                    case .Done:
                        BackupDoneView {
                            presentationMode.wrappedValue.dismiss()
                        } onNavigateBack: {
                            
                        }

                    }
                }
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
