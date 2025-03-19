//
//  CreateAccountFlow.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

public struct CreateAccountFlow: View {
    
    @State private var path = [Int]()
    var onFinish: ((Bool) -> Void)?
    var onEnteredName: ((String) -> Void)?
    
    @Environment(\.presentationMode) private var presentationMode
    
    public init(onEnteredName: ((String) -> Void)? = nil, onFinish: ( (Bool) -> Void)? = nil) {
        self.onFinish = onFinish
        self.onEnteredName = onEnteredName
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            CreateAccountNameView { name in
                onEnteredName?(name)
//                path = [0]
            }.navigationDestination(for: Int.self) { selection in
                switch selection {
                case 0:
                    CreatingAccountView{
                        onFinish?(true)
                    }
                    
                case 2:
                    ScanLoginQRCodeView {
                        onFinish?(true)
                    }
                    
                default:
                    Text("0")
                }
            }
        }
    }
}

#Preview {
    CreateAccountFlow()
}
