//
//  VerifyPhoneFlow.swift
//  SelfUI
//
//  Created by Long Pham on 31/7/24.
//

import SwiftUI

public struct VerifyPhoneFlow: View {
    @State private var path = [Int]()
    var onFinish: ((Bool) -> Void)?
    
    public init(onFinish: ( (Bool) -> Void)? = nil) {
        self.onFinish = onFinish
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            VerifyPhoneIntroView {
                path = [0]
            }.navigationDestination(for: Int.self) { selection in
                switch selection {
                case 0:
                    CustomSmsView()
                    
//                case 1:
                    
                    
                default:
                    Text("0")
                }
            }
        }
    }
}

#Preview {
    VerifyPhoneFlow()
}
