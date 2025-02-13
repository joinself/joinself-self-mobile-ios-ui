//
//  LoadingView.swift
//  SelfUI
//
//  Created by Long Pham on 23/9/24.
//

import SwiftUI

public struct LoadingView: View {
    let message: String
    
    public init (message: String) {
        self.message = message
    }
    
    public var body: some View {
        NavigationView {
            BaseProgressView (enableBackNavigation: false, totalSteps: 5, activeStep: 5, content: {
                ZStack {
                    Color.white
                        .ignoresSafeArea(.all)
                    VStack {
                        Text(message)
                            .font(.defaultLargeTitle)
                            .foregroundColor(.textPrimary)
                            .padding(.bottom, 80)
                        LoadingDotsView()
                    }
                }
            })
        }
    }
}

#Preview {
    ZStack {
        //EnterEmailCodeView(showAlert: .constant(false))
        LoadingView(message: "Checking your image.")
    }
    
}
