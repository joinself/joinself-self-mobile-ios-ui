//
//  ProgressStepViewModel.swift
//  SelfUI
//
//  Created by Long Pham on 22/5/24.
//

import Foundation

public class ProgressStepViewModel: ObservableObject {
    @Published var state: StepViewState = .inactive
    @Published var step: Int = 0
    @Published var currentStep: Int = 0
    
    init(step: Int, currentStep: Int) {
        self.step = step
        self.currentStep = currentStep
        
        if step == currentStep {
            state = .active
        } else if step < currentStep {
            state = .done
        } else {
            state = .inactive
        }
    }
}
