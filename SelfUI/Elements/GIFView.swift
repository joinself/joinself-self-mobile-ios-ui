//
//  GIFView.swift
//  SelfUI
//
//  Created by Long Pham on 29/5/24.
//

import SwiftUI
@_implementationOnly import FLAnimatedImage

struct GIFView: UIViewRepresentable {
    var gifName: String
    
    func makeUIView(context: Self.Context) -> FLAnimatedImageView {
        let view = FLAnimatedImageView()
        let path = mainBundle!.path(forResource: gifName, ofType: "gif")!
        let url = URL(fileURLWithPath: path)
        let gifData = try! Data(contentsOf: url)
        let gif = FLAnimatedImage(animatedGIFData: gifData)
        view.animatedImage = gif
        view.contentMode = .scaleAspectFill
        view.frame = CGRect(x: 0, y: 0, width: 379, height: 343)
        return view
    }
    
    func updateUIView(_ uiView: FLAnimatedImageView, context: UIViewRepresentableContext<GIFView>) {
        // Update the view if necessary.
    }
}
