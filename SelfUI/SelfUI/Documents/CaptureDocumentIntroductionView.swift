//
//  CaptureDocumentIntroductionView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct CaptureDocumentIntroductionView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    private let documentType: DocumentType
    
    public init(documentType: DocumentType = .passport, onGettingStarted: @escaping () -> Void, onNavigateBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigateBack = onNavigateBack
        self.documentType = documentType
    }
    
    var onGettingStarted: () -> Void
    var onNavigateBack: () -> Void
    public var onSelectNegative: (() -> Void)? = nil
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 2, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text(documentType == .passport ? String(format: "title_verify_document_introduction".localized, arguments: ["passport"]) : String(format: "title_verify_document_introduction".localized, arguments: ["ID document"]))
                    .modifier(Heading3TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Text(documentType == .passport ? String(format: "msg_verify_document_introduction".localized, arguments: ["passport"]) : String(format: "msg_verify_document_introduction".localized, arguments: ["ID document"]))
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
    CaptureDocumentIntroductionView(documentType: .identityCard, onGettingStarted: {
        
    }, onNavigateBack: {
        
    })
}
