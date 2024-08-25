//
//  CustomPageIndicator.swift
//  SelfUI
//
//  Created by Long Pham on 26/7/24.
//

import SwiftUI

struct CustomPageIndicator: View {
    let currentIndex: Int
    let total: Int
    
    // FIXME: Need to add more color here if the total greater than 4
    let colors: [Color] = [.defaultBlue, .defaultPink, .defaultYellow, .defaultGreen]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<total, id: \.self) { index in
                Circle()
                    .frame(width: self.currentIndex == index ? 18 : 10, height: self.currentIndex == index ? 18 : 10)
                    .foregroundColor(index < colors.count ? colors[index] : .defaultBlue)
                    .opacity(self.currentIndex == index ? 1 : 0.3)
            }
        }
    }
}

#Preview {
    VStack {
        CustomPageIndicator(currentIndex: 0, total: 4)
        CustomPageIndicator(currentIndex: 1, total: 4)
        CustomPageIndicator(currentIndex: 2, total: 4)
        CustomPageIndicator(currentIndex: 3, total: 4)
    }
}
