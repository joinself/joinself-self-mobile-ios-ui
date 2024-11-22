//
//  CaptureDocumentIntructionView.swift
//  SelfUI
//
//  Created by Long Pham on 29/5/24.
//

import SwiftUI

public struct CaptureDocumentIntructionView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    let title: String
    let details: String
    
    public init(title: String, details: String, onGettingStarted: @escaping () -> Void, onNavigationBack: @escaping () -> Void) {
        self.title = title
        self.details = details
        self.onGettingStarted = onGettingStarted
        self.onNavigationBack = onNavigationBack
    }
    
    var onGettingStarted: () -> Void
    var onNavigationBack: () -> Void
    
    public var body: some View {
        VStack {
            CustomProgressView(steps: [
                Step(title: "1", state: .done),
                Step(title: "2", state: .active),
                Step(title: "3", state: .inactive),
                Step(title: "4", state: .inactive),
                Step(title: "5", state: .inactive)
            ])
            
            VStack (spacing: 12){
                Text(title)
                    .font(.defaultTitle)
                    .foregroundColor(.textPrimary)
                Text(details)
                    .font(.defaultBody)
                    .lineSpacing(1.14)
                    .foregroundColor(.textPrimary)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 361, height: 327)
                    .background(
                        GIFView(gifName: "id_document_tips")
                            .frame(width: 361, height: 327)
                            .scaleEffect(x: 0.8, y: 0.8)
                            .clipped()
                    )
            }
            .padding()
            
            Spacer()
            
            VStack(spacing: 12) {
                ButtonView(title: "Capture".localized) {
                    onGettingStarted()
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
    CaptureDocumentIntructionView(title: String(format: "capture_document_title".localized, arguments: ["front"]), details: "msg_capture_document_front".localized) {
        
    } onNavigationBack: {
        
    }

}
