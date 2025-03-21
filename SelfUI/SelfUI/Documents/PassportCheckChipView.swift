//
//  PassportCheckChipView.swift
//  SelfUI
//
//  Created by Long Pham on 29/5/24.
//

import SwiftUI

public struct PassportCheckChipView: View {
    
    public init(onGettingStarted: @escaping () -> Void, onNavigationBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigationBack = onNavigationBack
    }
    
    var onGettingStarted: () -> Void
    var onNavigationBack: () -> Void
    public var onSelectNegative: (() -> Void)? = nil
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 2, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text("title_ask_passport_chip".localized)
                    .modifier(Heading3TextStyle())
                HStack {
                    Spacer()
                    Image("ic_nfc_chip", bundle: mainBundle)
                    Spacer()
                }
                Text("detail_ask_passport_chip".localized)
                    .modifier(Body1TextStyle())
            }
            
            Spacer()
            VStack {
                ButtonView(title: "Yes".localized, backgroundColor: .defaultPink) {
                    onGettingStarted()
                }
                
                OutlinedButton(title: "No".localized, outlineColor: .defaultPink) {
                    onNavigationBack()
                    onSelectNegative?()
                }
            }
        })
    }
}

#Preview {
    PassportCheckChipView(onGettingStarted: {
        
    }, onNavigationBack: {
        
    })
}

