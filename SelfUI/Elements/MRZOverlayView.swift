//
//  MRZOverlayView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

class MRZOverlayViewModel: ObservableObject {
    @Published var isHighlighted: Bool = false
}

struct MRZOverlayView: View {
    @ObservedObject var viewModel = MRZOverlayViewModel()
    
    init (isHighlighted: Bool = false) {
        viewModel.isHighlighted = isHighlighted
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            Image("mrz_frame", bundle: mainBundle)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .colorMultiply(viewModel.isHighlighted ? .defaultGreen : .white)
                .frame(width: 373, height: 252)
                .padding()
            TransparentHoleView(holeSize: CGSizeMake(373, 252))
                .background(Color.black.opacity(0.6))
                .ignoresSafeArea()
        }.ignoresSafeArea()
    }
}

#Preview {
    MRZOverlayView(isHighlighted: true)
}
