//
//  SelfieOverlayView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

class SelfieOverlayViewModel: ObservableObject {
    @Published var isHighlighted: Bool = false
}

struct SelfieOverlayView: View {
//    @ObservedObject var viewModel = CardOverlayViewModel()
    @Binding private var isHighlighted: Bool
    
    init (isHighlighted: Binding<Bool> = .constant(false)) {
        _isHighlighted = isHighlighted
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            Image("selfie_overlay_normal", bundle: mainBundle)
                .resizable()
                .colorMultiply(isHighlighted ? .defaultGreen : .white)
//                .frame(width: 363, height: 252)
//            TransparentHoleView(holeSize: CGSizeMake(373, 252))
//                .background(Color.black.opacity(0.0))
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        SelfieOverlayView(isHighlighted: .constant(false))
        SelfieOverlayView(isHighlighted: .constant(true))
            .opacity(0.5)
        
    }
    
}
