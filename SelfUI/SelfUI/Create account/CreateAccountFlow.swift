//
//  CreateAccountFlow.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

public struct CreateAccountFlow: BaseView {
    
    @State private var path = [Int]()
    var onFinish: ((Bool) -> Void)?
    
    @Environment(\.presentationMode) private var presentationMode
    
    public init(onFinish: ( (Bool) -> Void)? = nil) {
        self.onFinish = onFinish
    }
    
    public var body: some View {
        NavigationStack(path: $path) {
            CreateAccountNameView { name in
                path = [0]
            }.navigationDestination(for: Int.self) { selection in
                switch selection {
                case 0:
                    CreatingAccountView{
                        path = [1]
                    }
                    
                case 1:
                    ScanLoginQRCodeView {
                        
                    }
                    
                default:
                    Text("0")
                }
            }
        }.background(.white)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        NavBackButton()
                    }
                }
            }
    }
}

#Preview {
    CreateAccountFlow()
}
