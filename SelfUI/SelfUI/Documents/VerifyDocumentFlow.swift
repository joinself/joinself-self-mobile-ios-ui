//
//  VerifyDocumentFlow.swift
//  SelfUI
//
//  Created by Long Pham on 19/11/24.
//

import SwiftUI

enum NavigationDestinations: String, CaseIterable, Hashable {
    case Details
    case Profiles
    case Settings
}

struct VerifyDocumentFlow: View {
    @State private var path = [Int]()
    public var body: some View {
        NavigationStack(path: $path) {
            CaptureDocumentIntroductionView(onGettingStarted: {
                path = [0]
            }, onNavigateBack: {
                
            }).navigationDestination(for: Int.self) { selection in
                switch selection {
                case 0:
                    CaptureDocumentFrontIntructionView {
                        
                    } onNavigationBack: {
                        
                    }

                    
                default:
                    Text("0")
                }
            }
        }
    }
}

#Preview {
    VerifyDocumentFlow()
}
