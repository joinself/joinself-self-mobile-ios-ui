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
        HStack(alignment: .center, spacing: 10) {
            // Subtitle/Subtitle 2
            Text(message)
              .font(
                Font.defaultBodyMedium
              )
              .foregroundColor(Color(red: 0.05, green: 0.11, blue: 0.26))
        }
        .padding(10)
        .frame(width: 393, height: 24, alignment: .center)
        .background(Color(red: 0.98, green: 0.13, blue: 0.57))
    }
}

#Preview {
    BannerView(message: "No internet connection")
}
