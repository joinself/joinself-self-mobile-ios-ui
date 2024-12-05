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
    public var body: some View {
        NavigationStack(path: $path) {
            BackupInfoView(onGettingStarted: {
                path = [.BackingUp]
            }, onNavigateBack: {
                path = []
            })
            .navigationDestination(for: BackupDestinations.self) { destination in
                
                switch destination {
                case .Info:
                    Text("Backup")
                    
                case .BackingUp:
                    BackingupView {
                        
                    } onNavigateBack: {
                        
                    }

                    
                case .Done:
                    Text("Done")
                }
            }
        }
    }
}

#Preview {
    BackupFlow()
}
