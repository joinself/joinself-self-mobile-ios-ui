//
//  LivenessFlow.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI

public struct LivenessFlow: View {
    public init () {
        
    }
    
    public var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Set the background
            LivenessIntroductionView()
        }
    }
}

#Preview {
    LivenessFlow()
}
