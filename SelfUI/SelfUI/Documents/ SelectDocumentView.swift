//
//   SelectDocumentView.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import SwiftUI

public struct  SelectDocumentView: View {
    
    public var onSelect: ((_ documentType: DocumentType) -> Void)?
    var onResult: ((UIImage, UIImage) -> Void)?
    
    public init(onSelect: ((_ documentType: DocumentType) -> Void)? = nil, onResult: ((UIImage, UIImage) -> Void)? = nil) {
        self.onSelect = onSelect
        self.onResult = onResult
    }
    
    @State private var showVerifyDocument = false
    
    public var body: some View {
        
        BaseProgressView (enableBackNavigation: true, totalSteps: 5, activeStep: 1, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text("title_document_selection".localized)
                    .modifier(Heading3TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Text("detail_document_selection".localized)
                    .modifier(Body1TextStyle())
                Spacer()
            }
            
            Spacer()
            VStack(spacing: 12) {
                ButtonView(title: "Passport".localized) {
                    onSelect?(.passport)
                }
                
                ButtonView(title: "Identity document".localized, backgroundColor: .defaultBlue) {
                    onSelect?(.identityCard)
//                    showVerifyDocument = true
                }
                .fullScreenCover(isPresented: $showVerifyDocument) {
                    showVerifyDocument = false
                } content: {
                    VerifyDocumentFlow(onResult: onResult)
                }
            }
        })
    }
}

#Preview {
    SelectDocumentView()
}
