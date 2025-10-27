//
//  LivenessView.swift
//  SelfUI
//
//  Created by Long Pham on 14/5/24.
//

import SwiftUI

public struct LivenessOverlayView: View {
    
    @Binding var isHighlighted: Bool
    public init(isHighlighted: Binding<Bool>) {
        self._isHighlighted = isHighlighted
    }
    
    public var body: some View {
        Image(isHighlighted ? "selfie_overlay_highlight" : "selfie_overlay_normal", bundle: mainBundle)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    VStack {
        LivenessOverlayView(isHighlighted: .constant(true))
        LivenessOverlayView(isHighlighted: .constant(false))
    }
}
