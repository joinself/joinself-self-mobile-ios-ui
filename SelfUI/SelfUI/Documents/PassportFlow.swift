//
//  PassportFlow.swift
//  SelfUI
//
//  Created by Long Pham on 21/3/25.
//

import SwiftUI

public struct PassportFlow: View {
    @State private var path = [Int]()
    
    public init () {
        
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            DocumentNFCCheckView(documentType: .passport) {
                    path = [0]
            } onCancel: {
            
            }
        }.navigationDestination(for: Int.self) { destination in
            switch destination {
            case 0:
                Text("0")
                
            default:
                Text("undefined")
            }
        }
    }
}

#Preview {
    PassportFlow()
}
