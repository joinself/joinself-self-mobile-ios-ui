//
//  PassportStartScanView.swift
//  SelfUI
//
//  Created by Long Pham on 31/5/24.
//

import SwiftUI

public struct PassportStartScanView: View {
     
    public init(onGettingStarted: @escaping () -> Void, onNavigationBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigateBack = onNavigationBack
        Utils.instance.applyDefaultFonts()
    }
    
    var onGettingStarted: () -> Void
    var onNavigateBack: () -> Void
    
    public var body: some View {
        
        BaseProgressView (totalSteps: 5, activeStep: 2, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text("title_start_scan_passport".localized)
                    .modifier(Heading3TextStyle())
                
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 361, height: 327)
                  .background {
                      GIFView(gifName: "start_scan")
                          .frame(width: 361, height: 327)
                        .scaleEffect(x: 0.8, y: 0.8)
                        .clipped()
                  }
            }
            ButtonView(title: "Start scan".localized) {
                onGettingStarted()
            }
        })
    }
}

#Preview {
    PassportStartScanView(onGettingStarted: {
        
    }, onNavigationBack: {
        
    })
}
