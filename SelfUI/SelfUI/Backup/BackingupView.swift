//
//  BackingupView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct BackingupView: View {
    
    public init(onGettingStarted: @escaping () -> Void, onNavigateBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigateBack = onNavigateBack
    }
    
    var onGettingStarted: () -> Void
    var onNavigateBack: () -> Void
    public var onSelectNegative: (() -> Void)? = nil
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            LoadingDotsView()
            
            Spacer()
            VStack(spacing: 12) {
                ButtonView(title: "button_backup_now".localized) {
                    onGettingStarted()
                }.hidden()
                
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
    BackingupView(onGettingStarted: {
        
    }, onNavigateBack: {
        
    })
}
