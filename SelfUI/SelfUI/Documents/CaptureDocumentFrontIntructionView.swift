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
        BaseProgressView (totalSteps: 5, activeStep: 2, content: {
            VStack (spacing: 30) {
                Text(title)
                    .modifier(Heading3TextStyle(scale: 1.0))
                    //.padding(.top, Constants.PaddingTopMedium)
                Text(details)
                    .modifier(Body1TextStyle())
                
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
            
            Spacer()
            
            ButtonView(title: "Capture".localized) {
                onGettingStarted()
            }
        })
    }
}

#Preview {
    CaptureDocumentIntructionView(title: String(format: "capture_document_title".localized, arguments: ["front"]), details: "msg_capture_document_front".localized) {
        
    } onNavigationBack: {
        
    }

}
