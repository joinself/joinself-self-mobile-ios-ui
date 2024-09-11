//
//  NavBackButton.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

struct NavBackButton: View {
    var onClick: (() -> ())?
    init(onClick: (() -> Void)? = nil) {
        self.onClick = onClick
    }
    var body: some View {
        HStack {
            Image("ic_back_dark", bundle: mainBundle)
        }.onTapGesture {
            onClick?()
        }
    }
}

#Preview {
    NavBackButton()
}
