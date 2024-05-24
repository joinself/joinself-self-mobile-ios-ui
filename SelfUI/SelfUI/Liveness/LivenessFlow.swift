//
//  LivenessFlow.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI

public struct LivenessFlow: View {
    @State private var isDetailViewVisible = false
    
    public init () {
        
    }
    
    public var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Set the background
            if isDetailViewVisible {
                LivenessView {
                    self.isDetailViewVisible = false
                }
                
            } else {
                LivenessIntroductionView {
                    self.isDetailViewVisible = true
                } onNavigationBack: {
                    
                }
            }
        }
    }
}

#Preview {
    LivenessFlow()
}
