//
//  PassportFlow.swift
//  SelfUI
//
//  Created by Long Pham on 21/3/25.
//

import SwiftUI

public struct PassportFlow: View {
    @State private var path = [Int]()
    @Environment(\.presentationMode) private var presentationMode
    
    public init () {
        
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            PassportIntroductionView(onGettingStarted: {
                // TODO: Do liveness check
                
            }, onNavigateBack: {
                presentationMode.wrappedValue.dismiss()
            })
            .navigationDestination(for: Int.self) { selection in
                
            }
        }
    }
}

#Preview {
    PassportFlow()
}
