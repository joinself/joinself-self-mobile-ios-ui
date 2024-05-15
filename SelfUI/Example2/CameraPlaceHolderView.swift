//
//  CameraPlaceHolderView.swift
//  Example2
//
//  Created by Long Pham on 15/5/24.
//

import SwiftUI

struct CameraPlaceHolderView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.secondary)
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Text("Camera Placeholder")
                        .foregroundColor(.white)
                        .bold()
                )
        }
        .frame(width: 300, height: 300) // Adjust the frame to your needs
    }
}

#Preview {
    CameraPlaceHolderView()
}
