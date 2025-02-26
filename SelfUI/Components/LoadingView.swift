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
                VStack {
                    Text(message)
                        .modifier(Heading1TextStyle())
                        .padding(.top, Constants.Heading1PaddingTop)
                    LoadingDotsView()
                        .padding(.top, 80)
                    Spacer()
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
