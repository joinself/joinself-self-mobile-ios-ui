//
//  BrandView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI

let mainBundleId = "com.joinself.mobile.ui.SelfUI"
let mainBundle = Bundle(identifier: mainBundleId)

class BrandViewModel: ObservableObject {
    @Published var isDarked =  false
}

struct BrandView: View {
    @ObservedObject var viewModel = BrandViewModel()
    
    init(isDarked: Bool) {
        self.viewModel.isDarked = isDarked
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: 10) {
                Text("Powered by")
                    .font(Font.system(size: 15).weight(.medium))
                    .lineSpacing(22)
                    .foregroundColor(viewModel.isDarked ? .black : .white)
                Image(viewModel.isDarked ? "ic_self" : "ic_self_white", bundle: mainBundle)
                    .resizable()
                    .aspectRatio(contentMode: .fill) // Fill the frame maintaining aspect ratio
                    .frame(width: 30, height: 30) // Set fixed width and height
                    .clipped() // Clip the image to the bounds of the frame
            }
        }
    }
}

#Preview {
    BrandView(isDarked: true)
}
