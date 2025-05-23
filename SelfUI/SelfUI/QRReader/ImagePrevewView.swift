//
//  ImagePrevewView.swift
//  SelfUI
//
//  Created by Long Pham on 9/10/24.
//

import SwiftUI

public struct ImagePreviewView: View {
    @Binding var uiImage: UIImage?
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    public init(uiImage: Binding<UIImage?> = .constant(nil)) {
        self._uiImage = uiImage
        print("Self iiiiimage: \(uiImage)")
    }
    public var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scale)
                    .gesture(MagnificationGesture()
                        .onChanged { value in
                            self.scale = self.lastScale * value
                        }
                        .onEnded { value in
                            self.lastScale = self.scale
                        }
                    )
                    .animation(.easeInOut, value: scale)
                    .onTapGesture(count: 2) {
                        self.scale = 1.0
                    }
            }
        }
    }
}

#Preview {
    ImagePreviewView(uiImage: .constant(UIImage(named: "ic_self_logo", in: mainBundle, with: nil)!))
}
