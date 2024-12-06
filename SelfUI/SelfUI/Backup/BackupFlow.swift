//
//  BackupFlow.swift
//  SelfUI
//
//  Created by Long Pham on 5/12/24.
//

import SwiftUI

enum BackupDestinations: String, CaseIterable, Hashable {
    case Info
    case BackingUp
    case Done
}

public struct BackupFlow: View {
    @State private var path: [BackupDestinations] = [BackupDestinations]()
    @Binding var backupFinish: Bool
    @Environment(\.presentationMode) private var presentationMode
    private var onBackingup: (() -> Void)?
    public init(backupFinish: Binding<Bool> = .constant(false), onBackingup: (() -> Void)? = nil) {
        self._backupFinish = backupFinish
        self.onBackingup = onBackingup
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            BackupInfoView(onGettingStarted: {
                path = [.BackingUp]
                onBackingup?()
            }, onNavigateBack: {
                path = []
            })
            .onChange(of: self.backupFinish, perform: { newValue in
                if backupFinish {
                    path = [.Done]
                }
            })
            .navigationDestination(for: BackupDestinations.self) { destination in
                
                switch destination {
                case .Info:
                    Text("Backup")
                    
                case .BackingUp:
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
    }
}

#Preview {
    BackupFlow()
}
