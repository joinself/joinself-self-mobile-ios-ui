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

public struct RestoreFlow: View {
    @State private var path: [RestoreDestinations] = [RestoreDestinations]()
    @Binding var backupFinish: Bool
    @Binding var isNetworkConnected: Bool
    @Environment(\.presentationMode) private var presentationMode
    private var onBackingup: (() -> Void)?
    public init(backupFinish: Binding<Bool> = .constant(false), isNetworkConnected: Binding<Bool> = .constant(true), onBackingup: (() -> Void)? = nil) {
        self._backupFinish = backupFinish
        self._isNetworkConnected = isNetworkConnected
        self.onBackingup = onBackingup
    }
    
    public var body: some View {
        VStack {
            if !isNetworkConnected {
                BannerView(message: "no_internet_connection".localized)
            }
            
            NavigationStack(path: $path) {
                RestoreIntroView {
                    path = [.LivenessCheck]
                }
                .onChange(of: self.backupFinish, perform: { newValue in
                    if backupFinish {
                        path = [.Done]
                    }
                })
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
    }
}

#Preview {
    VStack {
        RestoreFlow(isNetworkConnected: .constant(false))
    }
    
}
