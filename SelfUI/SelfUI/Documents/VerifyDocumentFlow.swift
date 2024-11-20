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

public struct VerifyDocumentFlow: View {
    @State private var path = [Int]()
    public init() {
    }
    public var body: some View {
        NavigationStack(path: $path) {
            DocumentNFCCheckView(title: String(format: "title_ask_document_chip".localized, arguments: ["document"]), details: String(format: "detail_ask_document_chip".localized, arguments: ["document"]), onOK: {
                path = [0]
            }, onCancel: {
                // TODO: does not have chip
            })
            .navigationDestination(for: Int.self) { selection in
                switch selection {
                case 0:
                    CaptureDocumentIntroductionView(onGettingStarted: {
                        path = [1]
                    }, onNavigateBack: {
                        
                    })
                    
                case 1:
                    CaptureDocumentFrontIntructionView {
                        path = [2]
                    } onNavigationBack: {
                        
                    }

                case 2:
                    CaptureDocumentView()
                    
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
