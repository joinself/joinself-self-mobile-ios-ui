//
//  StatusLabel.swift
//  SelfUI
//
//  Created by Long Pham on 10/10/24.
//

import SwiftUI

struct StatusLabel: View {
    let backgroundColor: Color
    let label: String
    
    init(label: String, backgroundColor: Color) {
        self.label = label
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            // Paragraph/Caption
            Text(label)
              .font(.defaultButton)
              .kerning(0.12)
              .foregroundColor(.white)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 2)
        .background(backgroundColor)
        .cornerRadius(40)
    }
}

#Preview {
    VStack {
        StatusLabel(label: "Rejected", backgroundColor: .defaultPink)
        StatusLabel(label: "Agreed", backgroundColor: .defaultGreen)
    }
    
}
