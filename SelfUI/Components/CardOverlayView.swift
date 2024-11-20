//
//  MRZOverlayView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

class CardOverlayViewModel: ObservableObject {
    @Published var isHighlighted: Bool = false
}

struct CardOverlayView: View {
    @ObservedObject var viewModel = CardOverlayViewModel()
    
    init (isHighlighted: Bool = false) {
        viewModel.isHighlighted = isHighlighted
    }
    
    var body: some View {
        ZStack {
//            Color.clear
//                .ignoresSafeArea()
            Image("capture_document_front", bundle: mainBundle)
                .resizable()
                .colorMultiply(viewModel.isHighlighted ? .defaultGreen : .white)
                .frame(width: 363, height: 252)
//            TransparentHoleView(holeSize: CGSizeMake(373, 252))
//                .background(Color.black.opacity(0.0))
//                .ignoresSafeArea()
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            CardOverlayView(isHighlighted: false)
//            CardOverlayView(isHighlighted: true)
        }
    }
    
}
