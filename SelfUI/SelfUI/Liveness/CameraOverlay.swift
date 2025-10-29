//
//  CameraOverlay.swift
//  SelfUI
//
//  Created by Long Pham on 29/10/25.
//

import SwiftUI

public enum Position: String, Codable {
    case none
    case left
    case right
    case up
    case down
}

public struct CameraOverlay: View {
    @Binding var isHighlighted: Bool
    @Binding var message: String
    @Binding var position: Position
    public init(isHighlighted: Binding<Bool>, message: Binding<String>, position: Binding<Position>) {
        self._isHighlighted = isHighlighted
        self._message = message
        self._position = position
    }
    
    public var body: some View {
        ZStack {
            LivenessOverlayView(isHighlighted: $isHighlighted)
            if !message.isEmpty {
                LivenessChallengeView(message: $message, position: $position)
                    .padding(.bottom, 80)
            }
        }
    }
}

#Preview {
    CameraOverlay(isHighlighted: .constant(true), message: .constant("Move Further Away"), position: .constant(.none))
}
