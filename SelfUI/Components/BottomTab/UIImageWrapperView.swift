//
//  UIImageWrapperView.swift
//  SelfUI
//
//  Created by Long Pham on 27/9/24.
//

import SwiftUI
import UIKit

struct UIImageViewRepresentable: UIViewRepresentable {
    var image: UIImage
    var tintColor: UIColor
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = tintColor
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = image
    }
}

struct UIImageWrapperView: View {
    let imageName: String
    init(imageName: String) {
        self.imageName = imageName
    }
    
    var body: some View {
        VStack {
            if let uiImage = UIImage(named: imageName, in: mainBundle, with: nil)?.withRenderingMode(.alwaysTemplate) {
                UIImageViewRepresentable(image: uiImage, tintColor: UIColor.blue)
//                    .frame(width: 25, height: 25)
            } else {
                Text("Image not found")
                    .onAppear {
                        print("AA: \(Bundle.main.bundleURL)")
                    }
            }
        }
    }
}

#Preview {
    HStack {
        UIImageWrapperView(imageName: "ic_data")
        UIImageWrapperView(imageName: "ic_data")
    }
    
}
