//
//  LivenessCameraView.swift
//  SelfUI
//
//  Created by Long Pham on 20/5/24.
//

import SwiftUI

public struct LivenessCameraView: View {
    @State private var disappear = false
    public var completion: (() -> Void)?
    
    public init () {
        
    }
    
    public var body: some View {
        ZStack {
        }
        .onAppear {
            print("ContentView appeared!")
        }
        .onDisappear {
            print("ContentView disappeared!")
            self.completion?()
        }
    }
}

#Preview {
    LivenessCameraView()
}
