//
//  OverlayLoadingView.swift
//  SelfUI
//
//  Created by Long Pham on 23/9/24.
//

import SwiftUI

public struct OverlayLoadingView: View {
    
    public init () {
    }
    
    public var body: some View {
        ZStack {
            Color.defaultOverlay
            VStack(alignment: .center, spacing: 0) {
                VStack {
                    Spacer()
                    LoadingDotsView()
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        OverlayLoadingView()
    }
    
    
}
