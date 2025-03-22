//
//  CaptureDocumentIntroductionView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct CaptureDocumentIntroductionView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    public init(onGettingStarted: @escaping () -> Void, onNavigateBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigateBack = onNavigateBack
    }
    
    var onGettingStarted: () -> Void
    var onNavigateBack: () -> Void
    public var onSelectNegative: (() -> Void)? = nil
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 2, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text("capture_document_introduction".localized)
                    .modifier(Heading3TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Text("msg_capture_document_introduction".localized)
                    .modifier(Body1TextStyle())
                Spacer()
            }
            .padding()
            
            Spacer()
            ButtonView(title: "Get Started".localized) {
                onGettingStarted()
            }
        })
    }
}

#Preview {
    CaptureDocumentIntroductionView(onGettingStarted: {
        
    }, onNavigateBack: {
        
    })
}
