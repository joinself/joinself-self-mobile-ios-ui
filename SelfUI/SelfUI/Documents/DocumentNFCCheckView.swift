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
    
    public init(title: String, details: String = "", onOK: (() -> Void)? = nil, onCancel: (() -> Void)? = nil) {
        self.title = title
        self.details = details
        self.onOK = onOK
        self.onCanel = onCancel
    }
    
    var onOK: (() -> Void)?
    var onCanel: (() -> Void)?
    public var onSelectNegative: (() -> Void)? = nil
    
    public var body: some View {
        VStack {
            CustomProgressView(steps: [
                Step(title: "1", state: .active),
                Step(title: "2", state: .inactive),
                Step(title: "3", state: .inactive),
                Step(title: "4", state: .inactive),
                Step(title: "5", state: .inactive)
            ])
            
            VStack(alignment: .center, spacing: 30) {
                Text(title)
                    .font(.defaultTitle)
                    .foregroundColor(.textPrimary)
                Image("ic_nfc_chip", bundle: mainBundle)
                Text(details)
                    .font(.defaultBody)
                  .lineSpacing(1.14)
                  .foregroundColor(.black)
                Spacer()
            }
            .padding(EdgeInsets(top: 50, leading: 24, bottom: 10, trailing: 24))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
            VStack(spacing: 12) {
                ButtonView(title: "Yes".localized, backgroundColor: .defaultPink) {
                    onOK?()
                }
                
                OutlinedButton(title: "No".localized, outlineColor: .defaultPink) {
                    onCanel?()
                }
                
                BrandView(isDarked: true)
            }.padding()
        }
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavBackButton(isWhiteBackground: false) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    DocumentNFCCheckView(title: String(format: "title_ask_document_chip".localized, arguments: ["document"]),
                         details:
                            String(format: "detail_ask_document_chip".localized, arguments: ["document"]))
}

