//
//  ChipView.swift
//  SelfUI
//
//  Created by Long Pham on 6/3/25.
//

import SwiftUI

struct ChipView: View {
    let text: String
    let color: Color
    init (text: String, color: Color = .colorPrimary) {
        self.text = text
        self.color = color
    }
    var body: some View {
        HStack(alignment: .center, spacing: 4.53869) {
            Text(text)
                .modifier(Body2TextStyle(color: color))
        }
        .padding(.leading, 6.05159)
        .padding(.trailing, 9.07738)
        .padding(.vertical, 1.5129)
        .background(color.opacity(0.2))
        .cornerRadius(9.07738)
    }
}

#Preview {
    VStack {
        ChipView(text: "ACME", color: Color.colorSecondary)
        ChipView(text: "ACME", color: Color.colorPrimary)
        ChipView(text: "ACME", color: Color.colorTertiary)
        ChipView(text: "ACME", color: Color.colorQuaternary)
        ChipView(text: "ACME", color: Color.colorQuinary)
    }
}
