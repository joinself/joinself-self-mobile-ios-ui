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
        VStack {
            CustomProgressView(steps: [
                Step(title: "1", state: .active),
                Step(title: "2", state: .inactive),
                Step(title: "3", state: .inactive),
                Step(title: "4", state: .inactive),
                Step(title: "5", state: .inactive)
            ])
            
            
            
            VStack(alignment: .leading, spacing: 30) {
                Text("capture_document_introduction".localized)
                    .font(.defaultTitle)
                    .foregroundColor(.textPrimary)
                Text("msg_capture_document_introduction".localized)
                    .font(.defaultBody)
                  .lineSpacing(1.14)
                    .foregroundColor(.textPrimary)
                Spacer()
            }
            .padding()
            
            Spacer()
            VStack(spacing: 12) {
                ButtonView(title: "Get Started".localized) {
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
    CaptureDocumentIntroductionView(onGettingStarted: {
        
    }, onNavigateBack: {
        
    })
}
