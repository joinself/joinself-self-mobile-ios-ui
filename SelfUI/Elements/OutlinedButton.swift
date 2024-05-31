//
//  OutlinedButton.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import SwiftUI

class OutlinedButtonViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var outlinedColor: Color = .defaultGreen
    @Published var borderWidth: CGFloat = 2
    @Published var cornerRadius: CGFloat = 40
    @Published var icon: Image?
}

struct OutlinedButton: View {
    @ObservedObject var viewModel = OutlinedButtonViewModel()
    
    var onClicked: (() -> Void)? = nil
    
    init(title: String, outlineColor: Color = .defaultGreen, icon: Image? = nil, onClicked: (() -> Void)? = nil) {
        self.onClicked = onClicked
        self.viewModel.outlinedColor = outlineColor
        self.viewModel.title = title
        self.viewModel.icon = icon
        
        self.applyDefaultFonts()
    }
    
    private func applyDefaultFonts() {
        UIFont.jbs_registerFont(
            withFilenameString: "Barlow-Bold.ttf",
            bundle: Bundle(identifier: mainBundleId)!
        )
        
        UIFont.jbs_registerFont(
            withFilenameString: "Barlow-Regular.ttf",
            bundle: Bundle(identifier: mainBundleId)!
        )
    }
    
    var body: some View {
        HStack(spacing: 10) {
            viewModel.icon
                .colorMultiply(viewModel.outlinedColor)
            Text(viewModel.title)
            .font(Font.custom("Barlow", size: 17).weight(.bold))
            .tracking(0.85)
            .textCase(.uppercase)
            .foregroundColor(viewModel.outlinedColor)
        }
        .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
        .frame(width: 363, height: 44)
        .cornerRadius(viewModel.cornerRadius)
        .overlay(
          RoundedRectangle(cornerRadius: 40)
            .inset(by: 1)
            .stroke(viewModel.outlinedColor, lineWidth: viewModel.borderWidth)
        )
        .onTapGesture {
            onClicked?()
        }
    }
}

#Preview {
    OutlinedButton(title: "No", outlineColor: .defaultPink, icon: Image("ic_keyboard", bundle: mainBundle))
}
