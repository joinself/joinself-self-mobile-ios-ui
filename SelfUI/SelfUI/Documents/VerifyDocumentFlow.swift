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
    @State private var frontPageImage: UIImage?
    @State private var backPageImage: UIImage?
    var onResult: ((UIImage, UIImage) -> Void)?
    
    public init(onResult: ((UIImage, UIImage) -> Void)? = nil) {
        self.onResult = onResult
    }
    public var body: some View {
        NavigationStack(path: $path) {
            CaptureDocumentIntroductionView(onGettingStarted: {
                path = [1]
            }, onNavigateBack: {
                
            })
            .navigationDestination(for: Int.self) { selection in
                switch selection {
                case 0:
                    CaptureDocumentIntroductionView(onGettingStarted: {
                        path = [1]
                    }, onNavigateBack: {
                        
                    })
                    
                case 1:
                    CaptureDocumentIntructionView(title: String(format: "capture_document_title".localized, arguments: ["front"]), details: "msg_capture_document_front".localized) {
                        path = [2]
                    } onNavigationBack: {
                        
                    }

                case 2:
                    CaptureDocumentView(onCaptureImage:  { image in
                        self.frontPageImage = image
                        path = [3]
                    }, captureMode: .captureFrontPage)
                    
                case 3:
                    CaptureDocumentIntructionView(title: String(format: "capture_document_title".localized, arguments: ["back"]), details: "msg_capture_document_back".localized) {
                        path = [4]
                    } onNavigationBack: {
                        
                    }
                    
                case 4:
                    CaptureDocumentView(onCaptureImage:  { image in
                        self.backPageImage = image
                        print("Front image: \(self.frontPageImage)")
                        print("Back image: \(self.backPageImage)")
                        
                        path = [5]
                    }, captureMode: .captureBackPage)
                    
                case 5:
                    DocumentVerifyingView(onBack:  {
                        
                    }) {
                        guard let frontPageImage = frontPageImage else {
                            return
                        }
                        
                        guard let backPageImage = backPageImage else {
                            return
                        }
                        
                        onResult?(frontPageImage, backPageImage)
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
