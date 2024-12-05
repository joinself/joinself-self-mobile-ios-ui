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
        BaseView {
            Spacer()
            LoadingDotsView()
            Spacer()
        }
    }
}

#Preview {
    BackingupView(onGettingStarted: {
        
    }, onNavigateBack: {
        
    })
}
