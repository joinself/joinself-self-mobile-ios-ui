//
//  LivenessVerificationFailedView.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import SwiftUI

public struct LivenessVerificationFailedView: View {
    @ObservedObject var viewModel = LivenessVerificationViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(remainingRetryNumber: Int = 0, onGettingStarted: @escaping () -> Void, onNavigationBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigationBack = onNavigationBack
        self.viewModel.remainingRetryNumber = remainingRetryNumber
        self.viewModel.update()
    }
    
    var onGettingStarted: () -> Void
    var onNavigationBack: () -> Void
    
    public var body: some View {
        NavigationView {
            BaseProgressView (enableBackNavigation: false, totalSteps: 6, activeStep: 6, content: {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Verification failed".localized)
                        .modifier(Heading3TextStyle())
                        .padding(.top, 50)
                    Text(viewModel.bodyString)
                        .modifier(Body1TextStyle())
                    Spacer()
                }
                
                ButtonView(title: "Start".localized) {
                    presentationMode.wrappedValue.dismiss()
                    onGettingStarted()
                }
            })
        }
    }
}

#Preview {
    LivenessVerificationFailedView(onGettingStarted: {
        
    }, onNavigationBack: {
        
    })
}
