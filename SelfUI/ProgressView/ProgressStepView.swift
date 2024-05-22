//
//  ProgressStepView.swift
//  SelfUI
//
//  Created by Long Pham on 21/5/24.
//

import SwiftUI

enum StepViewState {
    case inactive
    case active
    case done
}

struct ProgressStepView: View {
    @ObservedObject var viewModel: ProgressStepViewModel = ProgressStepViewModel(step: 0, currentStep: 0)
    init(viewModel: ProgressStepViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .inactive:
                Image("ic_step_inactive", bundle: mainBundle)
                Text("\(viewModel.step)")
                    .font(Font.custom("SF Pro", size: 14).weight(.bold))
                    .tracking(0.12)
                    .lineSpacing(18)
                    .foregroundColor(.black)
            case .active:
                Ellipse()
                    .foregroundColor(.clear)
                    .frame(width: 32, height: 32)
                    .background(.white)
                    .overlay(
                        Ellipse()
                            .inset(by: 1.50)
                            .stroke(Color(red: 0, green: 0.64, blue: 0.43), lineWidth: 1.50)
                    )
                Text("\(viewModel.step)")
                    .font(Font.custom("SF Pro", size: 14).weight(.bold))
                    .tracking(0.12)
                    .lineSpacing(18)
                    .foregroundColor(.black)
            case .done:
                Image("ic_check", bundle: mainBundle)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
//        .frame(width: 32, height: 32);
    }
}

#Preview {
    ProgressStepView(viewModel: ProgressStepViewModel(step: 0, currentStep: 0))
}
