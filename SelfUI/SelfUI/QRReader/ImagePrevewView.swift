//
//  ImagePrevewView.swift
//  SelfUI
//
//  Created by Long Pham on 9/10/24.
//

import SwiftUI

public struct ImagePreviewView: View {
    let uiImage: UIImage?
    public init(uiImage: UIImage? = nil) {
        self.uiImage = uiImage
    }
    public var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(Color.white)
    //                .cornerRadius(10)
    //                .shadow(radius: 5)
            }
        }
    }
}

#Preview {
    ImagePreviewView(uiImage: UIImage(named: "ic_self_logo", in: mainBundle, with: nil)!)
}
