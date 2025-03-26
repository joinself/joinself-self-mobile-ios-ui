//
//  CustomButton.swift
//  SelfUI
//
//  Created by Long Pham on 10/10/24.
//

import SwiftUI

struct CustomButton: View {
    let buttonTitle: String
    let buttonTitleColor: Color
    private var action: (() -> ())?
    init(buttonTitle: String,
         buttonTitleColor: Color,
         action: (() -> ())? = nil) {
        self.buttonTitle = buttonTitle
        self.buttonTitleColor = buttonTitleColor
        self.action = action
    }
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack(alignment: .center, spacing: 10) {
                Text(buttonTitle)
                    .modifier(ButtonTextStyle(color: buttonTitleColor))
            }
            .padding(.horizontal, 0)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(.white)
            .cornerRadius(8)
        }
        .buttonStyle(.borderless)
    }
}

#Preview {
    ZStack {
        Color.blue.opacity(0.3).ignoresSafeArea()
        
        VStack {
            HStack (spacing: 20) {
                CustomButton(buttonTitle: "Accept", buttonTitleColor: .defaultGreen)
                CustomButton(buttonTitle: "Reject", buttonTitleColor: .defaultPink)
            }
        }.padding()

    }
}
