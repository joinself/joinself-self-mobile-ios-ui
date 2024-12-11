//
//  StepProgressView.swift
//  SelfUI
//
//  Created by Long Pham on 11/12/24.
//

import SwiftUI

struct StepProgressView: View {
    
    private var steps: [Step] = []
    private var totalSteps: Int = 5
    private var activeStep: Int = 3
    
    init(totalStep: Int = 5, activeStep: Int = 1) {
        print("Steps init: \(totalSteps)")
        for index in 1...totalSteps {
            if index < activeStep {
                steps.append(Step(title: "\(index)", state: .done))
            } else if index == activeStep {
                steps.append(Step(title: "\(index)", state: .active))
            } else {
                steps.append(Step(title: "\(index)", state: .inactive))
            }
            
        }
    }
    var body: some View {
        CustomProgressView(steps: steps)
            .background(.white)
    }
}

#Preview {
    StepProgressView(totalStep: 5, activeStep: 2)
}
