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
        VStack {
            Image("qr_overlay_normal", bundle: mainBundle)
                .colorMultiply(isValid ? .defaultGreen : .white)
        }.ignoresSafeArea(.all)
    }
}

#Preview {
    QRCodeOverlayView(isValid: .constant(false))
}

