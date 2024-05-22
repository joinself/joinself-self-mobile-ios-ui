//
//  SteppedProgressView.swift
//  SelfUI
//
//  Created by Long Pham on 21/5/24.
//

import SwiftUI

struct SteppedProgressView: View {
    // The current step the user is on
    @State private var currentStep: Int = 1
    @State private var progressColor: Color = .green
    @State private var backgroundColor: Color = .gray
    @State private var spacing: CGFloat = 0
    @State private var progress: CGFloat = 0
    
    
    @State private var progressBarWidth: CGFloat = 200
    @State private var progressViewWidth: CGFloat = 240
    
    @ObservedObject private var viewModel = SteppedProgressViewModel()
    
    // The total number of steps in the process
    let totalSteps: Int
    init(totalSteps: Int = 4, currentStep: Int, progressColor: Color, backgroundColor: Color = .gray) {
        self.currentStep = currentStep
        self.progressColor = progressColor
        self.totalSteps = totalSteps
        
        viewModel.progress = Double(currentStep) / Double(totalSteps)
        
        print("Spacing: \(spacing) currentStep: \(currentStep) totalSteps: \(totalSteps) progress \(progress) - p \(viewModel.progress)")
    }
    
    var body: some View {
        VStack(content: {
            
            // stepped progress view
            GeometryReader( content: { geometry in
                VStack(content: {
                    ZStack (alignment: .leading, content: {
                        ProgressView(value: currentStep == 1 ? 0 : viewModel.progress, total: 1.0)
                            .progressViewStyle(LinearProgressViewStyle())
                            .scaleEffect(x: 1, y: 3, anchor: .center) // Scale the height by 2 times
                            .tint(progressColor)
                            .background(Color.gray)
                            .frame(width: progressBarWidth, alignment: .leading)
                        HStack (alignment: .center, spacing: 0, content: {
                            ForEach((1...totalSteps), id: \.self) { step in
                                let stepViewModel = ProgressStepViewModel(step: step, currentStep: currentStep)
                                ProgressStepView(viewModel: stepViewModel)
                            }
                        })
                        .frame(width: progressViewWidth, alignment: .leading)
                    })
                }).onAppear(perform: {
                    progressViewWidth = geometry.size.width
                    let spacing = progressViewWidth/Double(totalSteps)
                    
                    progressBarWidth = geometry.size.width - spacing + 8
                })
                // end
            }).frame(height: 32)
            
            
            /*
            
            // Display the current step
            Text("Step \(currentStep) of \(totalSteps)")
            
            // Button to move to the next step
            Button("Next Step") {
                // Ensure we don't go beyond the total steps
                if currentStep <= totalSteps {
                    currentStep += 1
                } else {
                    currentStep = 1
                }
                
                progress = Double(currentStep) / Double(totalSteps)
                print("Spacing: \(spacing) currentStep: \(currentStep) totalSteps: \(totalSteps) progress \(progress)")
            }
            .disabled(currentStep > totalSteps + 1) // Disable the button if the last step is reached
             */
            
        })
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        
    }
}

struct SteppedProgressView_Previews: PreviewProvider {
    static var previews: some View {
        SteppedProgressView(totalSteps: 8, currentStep: 3, progressColor: .green, backgroundColor: .gray)
    }
}
