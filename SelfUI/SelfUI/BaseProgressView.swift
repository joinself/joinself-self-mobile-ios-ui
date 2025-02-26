//
//  BaseProgressView.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

struct BaseProgressView<Content: View>: View {
    
    private let content: Content
    private var totalSteps: Int = 5
    private var activeStep: Int = 3
    let enableBackNavigation: Bool
    
    @Environment(\.presentationMode) private var presentationMode
    private var onBack: (() -> Void)?
    init(enableBackNavigation: Bool = true, totalSteps: Int = Constants.ProgressStepNumber, activeStep: Int = 3, @ViewBuilder content: () -> Content, onBack: (() -> Void)? = nil) {
        self.content = content()
        self.totalSteps = totalSteps
        self.activeStep = activeStep
        self.enableBackNavigation = enableBackNavigation
        self.onBack = onBack
    }
    
    public var body: some View {
        VStack {
            StepProgressView(totalStep: totalSteps, activeStep: activeStep)
            BaseView(enableBackNavigation: enableBackNavigation) {
                // on back
                onBack?()
            } content: {
                content
            }
        }
        .background(.white)
    }
}

#Preview {
    BaseProgressView(totalSteps: 5, activeStep: 0, content: {
        Text("Hello Base View")
    })
}
