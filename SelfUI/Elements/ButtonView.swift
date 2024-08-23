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

struct ButtonView: View {
    @ObservedObject var viewModel = ButtonViewModel()
    var onClicked: (() -> Void)? = nil
    @State private var didTap: Bool = false
    private let opacity: CGFloat = 0.6
    private var buttonTitleColor: Color = .white
    
    init(title: String, backgroundColor: Color = .defaultGreen, buttonTitleColor: Color = .white, onClicked: (() -> Void)? = nil) {
        self.buttonTitleColor = buttonTitleColor
        self.viewModel.title = title
        self.viewModel.backgroundColor = backgroundColor
        self.onClicked = onClicked
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Button(action: {
                handleTap()
            }, label: {
                Text(viewModel.title)
                    .font(Font.system(size: 17).weight(.bold))
                    .tracking(0.85)
                    .textCase(.uppercase)
                    .foregroundColor(buttonTitleColor)
            })
            
        }
        .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
        .frame(width: 363, height: 44)
        .background(didTap ? viewModel.backgroundColor.opacity(opacity) : viewModel.backgroundColor)
        .cornerRadius(40)
        .onTapGesture {
            handleTap()
        }
    }
    
    private func handleTap() {
        didTap = true
        // Reset the state after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            didTap = false
            onClicked?()
        }
    }
}
#Preview {
    VStack {
        ButtonView(title: "Start", backgroundColor: .defaultPink)
        ButtonView(title: "Start", backgroundColor: .defaultOrange, buttonTitleColor: .textPrimary)
    }
}
