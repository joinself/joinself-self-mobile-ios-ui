//
//  ButtonView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI

class ButtonViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var backgroundColor: Color = Color.defaultGreen
}

public struct ButtonView: View {
    @ObservedObject var viewModel = ButtonViewModel()
    var onClicked: (() -> Void)? = nil
    @State private var didTap: Bool = false
    private let opacity: CGFloat = 0.6
    private var buttonTitleColor: Color = .white
    @Binding var isActive: Bool
    
    public init(title: String, backgroundColor: Color = .defaultGreen, buttonTitleColor: Color = .white, isActive: Binding<Bool> = .constant(true), onClicked: (() -> Void)? = nil) {
        self.buttonTitleColor = buttonTitleColor
        self._isActive = isActive
        self.viewModel.title = title
        self.viewModel.backgroundColor = backgroundColor
        self.onClicked = onClicked
        
    }
    
    public var body: some View {
        Button(action: {
            if isActive {
                onClicked?()
            }
        }, label: {
            HStack {
                Text(viewModel.title)
                    .font(.button)
                    .minimumScaleFactor(0.5)
                    .kerning(0.85)
                    .tracking(0.85)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .textCase(.uppercase)
                    .foregroundColor(isActive ? buttonTitleColor : Color.white)
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
            }
            .frame(maxWidth: .infinity, minHeight: Constants.MinButtonHeight)
            .background(isActive ? viewModel.backgroundColor : Color.defaultGray)
            .cornerRadius(Constants.ButtonCornerRadius)
        })
        .disabled(!isActive)
    }
}
#Preview {
    VStack {
        ButtonView(title: "Start", backgroundColor: .defaultPink, isActive: .constant(false))
        ButtonView(title: "Start", backgroundColor: .defaultPink, isActive: .constant(true))
        ButtonView(title: "Start", backgroundColor: .defaultOrange, buttonTitleColor: .textPrimary)
        ButtonView(title: "I’m going to develop with Self. Hello Button View", backgroundColor: .defaultOrange, buttonTitleColor: .textPrimary)
    }
}
