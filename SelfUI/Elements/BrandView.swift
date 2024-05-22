//
//  BrandView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI

let mainBundle = Bundle(identifier:"com.joinself.mobile.ui.SelfUI")

struct BrandView: View {
    var body: some View {
        ZStack {
            HStack(spacing: 10) {
                Text("Powered by")
                    .font(Font.custom("Barlow", size: 15).weight(.medium))
                    .lineSpacing(22)
                    .foregroundColor(.black)
                Image("ic_self", bundle: mainBundle)
                    .resizable()
                    .aspectRatio(contentMode: .fill) // Fill the frame maintaining aspect ratio
                    .frame(width: 30, height: 30) // Set fixed width and height
                    .clipped() // Clip the image to the bounds of the frame
            }
        }
//        .frame(width: .infinity, alignment: .leading)
    }
}

#Preview {
    BrandView()
}
