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
    
    @State private var path: [Int] = []
    
    public var body: some View {
        NavigationStack(path: $path) {
            VStack {
                LivenessIntroductionView {
                    self.isDetailViewVisible = true
                    print("Liveness....")
                    path = [1]
                } onNavigationBack: {
                    
                }
                .navigationDestination(for: Int.self) { selection in
                    switch selection {
                    case 1:
                        LivenessView {
                            
                        }
                    
                    default:
                        Text("0")
                    }
                    if isDetailViewVisible {
                        LivenessFlow()
                    }
                }
            }
        }
        .navigationTitle("Home")
    }
    
    /*public var body: some View {
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
     }*/
}

#Preview {
    LivenessFlow()
}
