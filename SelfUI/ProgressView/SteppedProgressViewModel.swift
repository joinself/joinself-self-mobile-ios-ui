//
//  SteppedProgressViewModel.swift
//  SelfUI
//
//  Created by Long Pham on 22/5/24.
//

import Foundation
import SwiftUI

class SteppedProgressViewModel: ObservableObject {
    @Published var progress: CGFloat = 0.0
    @Published var backgroundColor: Color = .defaultGray
    @Published var progressColor: Color = .defaultGreen
    @Published var currentStep: Int = 1
    @Published var progressBarWidth: CGFloat = 200
    @Published var progressViewWidth: CGFloat = 240
    @Published var spacing: CGFloat = 0
}
