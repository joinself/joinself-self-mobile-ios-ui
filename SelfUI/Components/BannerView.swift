//
//  BannerView.swift
//  SelfUI
//
//  Created by Long Pham on 25/8/24.
//

import SwiftUI

public struct BannerView: View {
    let message: String
    public init(message: String) {
        self.message = message
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // Subtitle/Subtitle 2
            
            Spacer()
            Text(message)
              .font(
                Font.defaultBodyMedium
              )
              .padding()
              .frame(maxWidth: .infinity, maxHeight: 24)
              .foregroundColor(.white)
              .background(Color.defaultPink)
        }
        .frame(maxHeight: 40)
        .background(Color.clear)
    }
}

#Preview {
    BannerView(message: "No internet connection")
}
