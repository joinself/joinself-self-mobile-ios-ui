//
//  BrandView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI

let mainBundleId = "com.joinself.next.ui"
let mainBundle = Bundle(identifier: mainBundleId)

class BrandViewModel: ObservableObject {
    @Published var isDarked =  false
}

public struct BrandView: View {
    @ObservedObject var viewModel = BrandViewModel()
    let textColor: Color
    
    public init(isDarked: Bool = true, textColor: Color = Color.textPrimary) {
        self.textColor = textColor
        self.viewModel.isDarked = isDarked
    }
    
    public var body: some View {
        ZStack {
            HStack(spacing: 10) {
                Text("Powered by")
                    .font(.defaultFootnote)
                    .lineSpacing(22)
                    .foregroundColor(textColor)
                Image(viewModel.isDarked ? "ic_self_pink" : "ic_self_white", bundle: mainBundle)
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
