//
//  NavBackButton.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

struct NavBackButton: View {
    var body: some View {
        HStack {
            Image("ic_back_dark", bundle: mainBundle)
        }
    }
}

#Preview {
    NavBackButton()
}
