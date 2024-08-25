//
//  TransparentHoleView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

class TransparentHoleViewModel: ObservableObject {
    @Published var size: CGSize = CGSizeMake(200, 200)
    @Published var cornerSize: CGSize = Utils.cornerSize
}

struct TransparentHoleView: View {
    @ObservedObject var viewModel = TransparentHoleViewModel()
    
    init(holeSize: CGSize, cornerSize: CGSize = Utils.cornerSize) {
        viewModel.size = holeSize
        viewModel.cornerSize = cornerSize
    }
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let holeSize: CGSize = viewModel.size
            let holePosition = CGPoint(x: size.width / 2 - holeSize.width / 2, y: size.height / 2 - holeSize.height / 2)
            
            Path { path in
                // Draw the full overlay
                
                path.addRoundedRect(in: CGRect(origin: .zero, size: size), cornerSize: viewModel.cornerSize)
                // Subtract the hole rectangle from the path
                path.addRoundedRect(in: CGRect(origin: holePosition, size: CGSize(width: holeSize.width, height: holeSize.height)), cornerSize: viewModel.cornerSize)
            }
            .fill(Color.black.opacity(0.6), style: FillStyle(eoFill: true))
        }.ignoresSafeArea()
    }
}

#Preview {
    TransparentHoleView(holeSize: CGSizeMake(373, 252), cornerSize: .zero)
}
