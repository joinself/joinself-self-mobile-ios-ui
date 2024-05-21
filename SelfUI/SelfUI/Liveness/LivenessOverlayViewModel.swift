//
//  LivenessOverlayViewModel.swift
//  SelfUI
//
//  Created by Long Pham on 21/5/24.
//

import Foundation

public class LivenessOverlayViewModel: ObservableObject {
    @Published var text: String
    @Published var isHighlighted: Bool
    @Published var tipImageName: String
    @Published var state: Challenge = .None

    init(text: String, tipImageName: String, isHighlighted: Bool) {
        self.text = text
        self.isHighlighted = isHighlighted
        self.tipImageName = tipImageName
    }
}
