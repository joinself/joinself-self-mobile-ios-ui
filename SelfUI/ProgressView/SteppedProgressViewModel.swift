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
    @Published var backgroundColor: Color = Color(red: 0.88, green: 0.88, blue: 0.88)
}
