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
        NavigationView {
            List {
                NavigationLink(destination: LivenessIntroductionView()) {
                    Text("Show Full Screen Detail")
                }
                
                NavigationLink(destination: BrandView()) {
                    Text("Brand View")
                }
                NavigationLink(destination: ButtonView()) {
                    Text("Button View")
                }
                NavigationLink(destination: LivenessView()) {
                    Text("Liveness View")
                }
                NavigationLink(destination: SteppedProgressView(totalSteps: 5, currentStep: 3, progressColor: .green, backgroundColor: .gray)
                ) {
                    Text("Stepped Progress View")
                }
            }
        }
    }
}

#Preview {
    LivenessFlow()
}
