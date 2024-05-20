//
//  CameraOvelayView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI

struct CameraOvelayView: View {
    @State var isHighlighted = false
    
    var body: some View {
        GeometryReader { geometry in
            Image(isHighlighted ? "selfie_overlay_highlight" : "selfie_overlay_normal" , bundle: mainBundle)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.isHighlighted.toggle() // test code
                }
        }
    }
}

#Preview {
    CameraOvelayView()
}
