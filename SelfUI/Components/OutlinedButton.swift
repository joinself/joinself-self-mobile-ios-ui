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

public struct OutlinedButton: View {
    @ObservedObject var viewModel = OutlinedButtonViewModel()
    @State private var didTap: Bool = false
    private let opacity: CGFloat = 0.6
    
    var onClicked: (() -> Void)? = nil
    
    public init(title: String, outlineColor: Color = .defaultGreen, icon: Image? = nil, onClicked: (() -> Void)? = nil) {
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
    
    public var body: some View {
        Button(action: {
            onClicked?()
        }, label: {
            HStack {
                viewModel.icon
                    .colorMultiply(didTap ? viewModel.outlinedColor.opacity(opacity) : viewModel.outlinedColor)
                Text(viewModel.title)
                    .font(.defaultButton)
                    .minimumScaleFactor(0.5)
                    .kerning(0.85)
                    .tracking(0.85)
                .textCase(.uppercase)
                .foregroundColor(didTap ? viewModel.outlinedColor.opacity(opacity) : viewModel.outlinedColor)
            }
//            .padding()
            .frame(maxWidth: .infinity, minHeight: Constants.MinButtonHeight)
            .cornerRadius(Constants.ButtonCornerRadius)
            .overlay(
              RoundedRectangle(cornerRadius: 40)
                .inset(by: 1)
                .stroke(didTap ? viewModel.outlinedColor.opacity(opacity) : viewModel.outlinedColor, lineWidth: viewModel.borderWidth)
            )
        })
    }
}

#Preview {
    OutlinedButton(title: "No", outlineColor: .defaultPink, icon: Image("ic_keyboard", bundle: mainBundle))
}
