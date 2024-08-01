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
    let phoneNumber: String
    let textMessage: String
    
    public init(phoneNumber: String, textMessage: String, onFinish: ( (Bool) -> Void)? = nil) {
        self.phoneNumber = phoneNumber
        self.textMessage = textMessage
        self.onFinish = onFinish
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            VerifyPhoneIntroView {
                path = [0]
            }.navigationDestination(for: Int.self) { selection in
                switch selection {
                case 0:
                    CustomSmsView(phoneNumber: phoneNumber, textMessage: textMessage) { success in
                        onFinish?(success)
                    }
                    
//                case 1:
                    
                    
                default:
                    Text("0")
                }
            }
        }
    }
}

#Preview {
    VerifyPhoneFlow(phoneNumber: "123456789", textMessage: "test")
}
