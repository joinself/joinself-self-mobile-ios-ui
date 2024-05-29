//
//  SteppedProgressView.swift
//  SelfUI
//
//  Created by Long Pham on 21/5/24.
//

import SwiftUI

struct SteppedProgressView: View {
    // The current step the user is on
    @ObservedObject private var viewModel = SteppedProgressViewModel()
    
    // The total number of steps in the process
    var totalSteps: Int = 5
    init(totalSteps: Int = 4, currentStep: Int, progressColor: Color = .defaultGreen, backgroundColor: Color = .defaultGray) {
        self.viewModel.currentStep = currentStep
        self.viewModel.progressColor = progressColor
        self.totalSteps = totalSteps
        
        viewModel.backgroundColor = backgroundColor
        viewModel.progress = Double(currentStep) / Double(totalSteps) - 0.07
        viewModel.spacing = viewModel.progressViewWidth / CGFloat(totalSteps)
        
        print("Spacing: \(viewModel.spacing) currentStep: \(currentStep) totalSteps: \(totalSteps) progress: \(viewModel.progress)")
    }
    
    var body: some View {
        VStack(content: {
            GeometryReader(content: { geometry in
                ZStack (alignment: .leading, content: {
                    ProgressView(value: viewModel.currentStep == 1 ? 0 : viewModel.progress, total: 1.0)
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .tint(viewModel.progressColor)
                        .frame(height: 10)
                        .background(viewModel.backgroundColor)
                        .frame(width: viewModel.progressBarWidth, alignment: .leading)
                    HStack (alignment: .center, spacing: 0, content: {
                        ForEach((1...totalSteps), id: \.self) { step in
                            let stepViewModel = ProgressStepViewModel(step: step, currentStep: viewModel.currentStep)
                            ProgressStepView(viewModel: stepViewModel)
                        }
                    })
                    .frame(width: viewModel.progressViewWidth, alignment: .leading)
                }).onAppear {
                    viewModel.progressBarWidth = geometry.size.width - viewModel.spacing
                    viewModel.progressViewWidth = geometry.size.width
                }
            })
        })
        .padding(.leading, 40)
        .frame(width: .infinity, height: 32)
    }
}

struct SteppedProgressView_Previews: PreviewProvider {
    static var previews: some View {
        SteppedProgressView(totalSteps: 5, currentStep: 2, progressColor: .defaultGreen, backgroundColor: .defaultGray)
    }
}
