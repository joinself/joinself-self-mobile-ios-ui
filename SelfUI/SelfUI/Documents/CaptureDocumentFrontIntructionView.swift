//
//  CaptureDocumentFrontIntructionView.swift
//  SelfUI
//
//  Created by Long Pham on 29/5/24.
//

import SwiftUI

public struct CaptureDocumentFrontIntructionView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    public init(onGettingStarted: @escaping () -> Void, onNavigationBack: @escaping () -> Void) {
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
            
            VStack {
                Text("capture_document_front".localized)
                    .font(.defaultTitle)
                    .foregroundColor(.textPrimary)
                Text("msg_capture_document_front".localized)
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
    CaptureDocumentFrontIntructionView(onGettingStarted: {
        
    }, onNavigationBack: {
        
    })
}
