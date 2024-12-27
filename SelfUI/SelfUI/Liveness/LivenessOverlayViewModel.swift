//
//  LivenessOverlayViewModel.swift
//  SelfUI
//
//  Created by Long Pham on 21/5/24.
//

import Foundation
import Combine
import SwiftUI
import AVFoundation

public class LivenessOverlayViewModel: ObservableObject {
    @Published var text: String
    @Published var isHighlighted: Bool
    @Published var tipImageName: String
    @Published var state: Challenge = .None
    var capturePublisher = PassthroughSubject<CMSampleBuffer?, Never>()

    public init(text: String, tipImageName: String, isHighlighted: Bool) {
        self.text = text
        self.isHighlighted = isHighlighted
        self.tipImageName = tipImageName
    }
}
