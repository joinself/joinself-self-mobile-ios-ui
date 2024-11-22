//
//  IDMRZCardOverlay.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

class IDMRZCardOverlayViewModel: ObservableObject {
    @Published var isHighlighted: Bool = false
}

struct IDMRZCardOverlay: View {
    @ObservedObject var viewModel = IDMRZCardOverlayViewModel()
    
    init (isHighlighted: Bool = false) {
        viewModel.isHighlighted = isHighlighted
    }
    
    var body: some View {
        ZStack {
            Image("frame_idcard_mrz", bundle: mainBundle)
                .resizable()
                .colorMultiply(viewModel.isHighlighted ? .defaultGreen : .white)
                .frame(width: 363, height: 252)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            IDMRZCardOverlay(isHighlighted: false)
            IDMRZCardOverlay(isHighlighted: true)
        }
    }
    
}
