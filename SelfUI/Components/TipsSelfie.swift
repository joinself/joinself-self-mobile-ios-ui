//
//  TipsSelfie.swift
//  SelfUI
//
//  Created by Long Pham on 20/5/24.
//

import SwiftUI

struct TipsSelfie: View {
    init(tipImageName: String = "bg_turn_left", tipDescription: String = "Look right and back") {
        self.tipImageName = tipImageName
        self.tipDescription = tipDescription
    }
    
    @State private var tipImageName = "bg_turn_left"
    @State private var tipDescription = "Look right and back"
    var body: some View {
        ZStack {
            Image(tipImageName, bundle: mainBundle)
            Text(tipDescription)
                .font(Font.custom("Barlow", size: 25).weight(.bold))
                .foregroundColor(.black)
                .offset(x: 0, y: 0)
        }
    }
}

#Preview {
    TipsSelfie()
}
