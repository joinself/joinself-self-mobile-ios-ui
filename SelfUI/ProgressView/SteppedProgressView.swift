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
    
    // The total number of steps in the process
    let totalSteps: Int
    init(totalSteps: Int = 4, currentStep: Int, progressColor: Color, backgroundColor: Color = .gray) {
        self.currentStep = currentStep
        self.progressColor = progressColor
        self.totalSteps = totalSteps
    }
    
    var body: some View {
        VStack(content: {
            
            GeometryReader(content: { geometry in
                // stepped progress view
                VStack(content: {
                    ZStack {
                        ProgressView(value: currentStep == 1 ? 0 : Double(currentStep - 1), total: Double(totalSteps))
                            .progressViewStyle(LinearProgressViewStyle())
                            .scaleEffect(x: 1, y: 2.5, anchor: .center) // Scale the height by 2 times
                            .tint(progressColor)
                            .background(Color.gray)
                            .padding(.trailing, spacing*2)
                        
                        HStack (alignment: .center, spacing: spacing, content: {
                            ForEach((1...totalSteps), id: \.self) { step in
                                
                                if step < currentStep {
                                    if step == 1 {
                                        ProgressStepView(state: .done, step: "\(step)")
                                            .padding(.leading, -spacing*2)
                                    } else {
                                        ProgressStepView(state: .done, step: "\(step)")
                                    }
                                } else if step == currentStep {
                                    if step == 1 {
                                        ProgressStepView(state: .active, step: "\(step)")
                                            .padding(.leading, -spacing*2)
                                    } else {
                                        ProgressStepView(state: .active, step: "\(step)")
                                    }
                                } else {
                                    ProgressStepView(state: .inactive, step: "\(step)")
                                }
                            }
                        })
                    }
                })
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .onAppear(perform: {
                    spacing = (geometry.size.width - 32*Double(totalSteps))/Double(totalSteps)
                    progress = Double(currentStep - 1)
                    
                    print("Spacing: \(spacing) currentStep: \(currentStep) progress: \(progress)")
                })
                
                // end
            }).frame(height: 32)
            
            
            
            // Display the current step
            Text("Step \(currentStep) of \(totalSteps)")
            
            // Button to move to the next step
            Button("Next Step") {
                // Ensure we don't go beyond the total steps
                if currentStep < totalSteps {
                    currentStep += 1
                } else {
                    currentStep = 1
                }
            }
            .disabled(currentStep > totalSteps) // Disable the button if the last step is reached
        })
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        
    }
}

struct SteppedProgressView_Previews: PreviewProvider {
    static var previews: some View {
        SteppedProgressView(totalSteps: 8, currentStep: 3, progressColor: .green, backgroundColor: .gray)
    }
}
