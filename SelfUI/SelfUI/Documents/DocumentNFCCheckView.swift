//
//  DocumentNFCCheckView.swift
//  SelfUI
//
//  Created by Long Pham on 29/5/24.
//

import SwiftUI

public struct DocumentNFCCheckView: View {
    @Environment(\.presentationMode) private var presentationMode
    let title: String
    let details: String
    
    public init(documentType: DocumentType = .passport,
                onOK: (() -> Void)? = nil,
                onCancel: (() -> Void)? = nil) {
        self.title = String(format: "title_ask_document_chip".localized, Utils.getDocumentName(type: documentType))
        self.details = String(format: "detail_ask_document_chip".localized, Utils.getDocumentName(type: documentType))
        self.onOK = onOK
        self.onCanel = onCancel
    }
    
    var onOK: (() -> Void)?
    var onCanel: (() -> Void)?
    public var onSelectNegative: (() -> Void)? = nil
    
    public var body: some View {
        BaseProgressView (enableBackNavigation: true, totalSteps: 5, activeStep: 2, content: {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(title)
                            .modifier(Heading3TextStyle(scale: 1))
                            .padding(.top, Constants.Heading1PaddingTop)
                            .id(1)
                        HStack {
                            Spacer()
                            Image("ic_nfc_chip", bundle: mainBundle)
                            Spacer()
                        }
                            .id(2)
                        Text(details)
                            .modifier(Body1TextStyle())
                            .id(3)
                    }
                }
                .onAppear {
                    proxy.scrollTo(3, anchor: .bottom)
                }
            }
            
            
            VStack(spacing: 12) {
                ButtonView(title: "Yes".localized, backgroundColor: .defaultPink) {
                    onOK?()
                }
                
                OutlinedButton(title: "No".localized, outlineColor: .defaultPink) {
                    onCanel?()
                }
            }
        })
    }
}

#Preview {
    DocumentNFCCheckView()
}

