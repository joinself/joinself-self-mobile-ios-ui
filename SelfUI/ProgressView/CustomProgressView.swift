//
//  CustomProgressView.swift
//  SelfUI
//
//  Created by Long Pham on 31/7/24.
//

import SwiftUI

struct Step: Identifiable {
    let id = UUID()
    let title: String
    let state: StepViewState
}

struct CustomProgressView: View {
    let steps: [Step]
    @Binding private var stepWidth: CGFloat
    init(steps: [Step], stepWidth: Binding<CGFloat> = .constant(50)) {
        self.steps = steps
        self._stepWidth = stepWidth
    }
    
    var body: some View {
        HStack (alignment: .center, spacing: 0) {
            ForEach(steps) { step in
                VStack (alignment: .center) {
                    ZStack {
                        switch step.state {
                        case .inactive:
                            Image("ic_step_inactive", bundle: mainBundle)
                        case .active:
                            Ellipse()
                                .foregroundColor(.clear)
                                .frame(width: 32, height: 32)
                                .background(.white)
                                .overlay(
                                    Ellipse()
                                        .inset(by: 1.50)
                                        .stroke(Color.defaultGreen, lineWidth: 3)
                                )
                        case .done:
                            Image("ic_check", bundle: mainBundle)
                        }
                        if step.state != .done {
                            // Paragraph/Caption
                            Text("\(step.title)")
                              .font(
                                Font.defaultCaption
                              )
                              .kerning(0.12)
                              .multilineTextAlignment(.center)
                              .foregroundColor(Color.defaultGrayscale)
                        }
                    }
                }
                if step.id != steps.last?.id {
                    Rectangle()
                        .fill(step.state == .done ? Color.defaultGreen : Color.defaultGray)
                        .frame(width: stepWidth, height: 5)
                }
            }
        }
    }
}

#Preview {
    CustomProgressView(steps: [
        Step(title: "0", state: .done),
        Step(title: "1", state: .done),
        Step(title: "2", state: .done),
        Step(title: "3", state: .active),
        Step(title: "4", state: .inactive),
    ])
}
