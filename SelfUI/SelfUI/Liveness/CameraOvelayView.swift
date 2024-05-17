//
//  CameraOvelayView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI

struct CameraOvelayView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.0) // Set the background color with 50% opacity
            .edgesIgnoringSafeArea(.all)
//            
            ZStack {
                // Overlay view with opacity
                Rectangle()
                    .foregroundColor(.clear)
                    .opacity(1)
                    .background(Color.clear)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        ZStack {
                            // Overlay view with opacity
                            Rectangle()
                                .foregroundColor(.clear)
                                .opacity(1)
                                .background(Color.clear)
                                .edgesIgnoringSafeArea(.all)
                                .overlay(
                                    Image("face_frame", bundle: mainBundle)
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .edgesIgnoringSafeArea(.horizontal)
                                )
                        }
                        .frame(width: 300, height: 300)
                    )
            }
        }
    }
}

#Preview {
    CameraOvelayView()
}
