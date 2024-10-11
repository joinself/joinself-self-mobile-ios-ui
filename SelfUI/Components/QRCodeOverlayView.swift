//
//  QRCodeOverlayView.swift
//  SelfUI
//
//  Created by Long Pham on 27/8/24.
//

import SwiftUI

struct QRCodeOverlayView: View {
    @Binding private var isValid: Bool
    init(isValid: Binding<Bool>) {
        self._isValid = isValid
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image(isValid ?  "qr_overlay_highlighted" : "qr_overlay_normal", bundle: mainBundle)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }.ignoresSafeArea()
        
    }
}

#Preview {
    ZStack {
        Color.defaultPink.ignoresSafeArea()
        QRCodeOverlayView(isValid: .constant(true))
    }
    
}

