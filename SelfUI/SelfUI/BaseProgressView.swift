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
    
    @Environment(\.presentationMode) private var presentationMode
    init(totalSteps: Int = Constants.ProgressStepNumber, activeStep: Int = 3, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.totalSteps = totalSteps
        self.activeStep = activeStep
    }
    
    public var body: some View {
        VStack {
            StepProgressView(totalStep: totalSteps, activeStep: activeStep)
            BaseView {
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
