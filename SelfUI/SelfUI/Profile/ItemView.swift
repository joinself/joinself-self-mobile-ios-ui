//
//  ItemView.swift
//  SelfUI
//
//  Created by Long Pham on 19/11/24.
//

import SwiftUI

struct ItemView: View {
    let title: String
    let icon: Image?
    init(title: String, icon: Image? = nil) {
        self.title = title
        self.icon = icon
    }
    
    var body: some View {
        HStack {
            if let icon {
                icon
            }
            Text(title)
                .font(.defaultBody)
                .foregroundStyle(Color.textPrimary)
            Spacer()
        }
        
    }
}

#Preview {
    VStack {
        ItemView(title: "Item", icon: Image("GB", bundle: mainBundle))
        ItemView(title: "Item", icon: nil)
    }
}
