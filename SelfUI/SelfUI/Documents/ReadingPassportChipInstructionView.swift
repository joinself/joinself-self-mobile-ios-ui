//
//  ReadingPassportChipInstructionView.swift
//  SelfUI
//
//  Created by Long Pham on 29/5/24.
//

import SwiftUI

public struct ReadingPassportChipInstructionView: View {
    
    public init(onGettingStarted: @escaping () -> Void, onNavigationBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigationBack = onNavigationBack
    }
    
    var onGettingStarted: () -> Void
    var onNavigationBack: () -> Void
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 2, content: {
            VStack(alignment: .leading, spacing: 10) {
                Text("title_capture_passport".localized)
                    .modifier(Heading3TextStyle())
                Text("detail_capture_passport".localized)
                    .modifier(Body1TextStyle())
                
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 361, height: 327)
                  .background(
                    GIFView(gifName: "passport_instructions")
                        .frame(width: 361, height: 327)
                        .scaleEffect(x: 0.8, y: 0.8)
                      .clipped()
                  )
            }
            
            ButtonView(title: "Capture".localized) {
                onGettingStarted()
            }
        })
    }
}

#Preview {
    ReadingPassportChipInstructionView(onGettingStarted: {
        
    }, onNavigationBack: {
        
    })
}
