//
//  ButtonView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI

class ButtonViewModel: ObservableObject {
    @Published var title: String = ""
}

struct ButtonView: View {
    @ObservedObject var viewModel = ButtonViewModel()
    var onClicked: (() -> Void)? = nil
    
    init(title: String, onClicked: (() -> Void)? = nil) {
        self.viewModel.title = title
        self.onClicked = onClicked
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Button(action: {
                onClicked?()
            }, label: {
                Text(viewModel.title)
                    .font(Font.system(size: 17).weight(.bold))
                    .tracking(0.85)
                    .textCase(.uppercase)
                    .foregroundColor(.white)
            })
            
        }
        .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
        .frame(width: 363, height: 44)
        .background(Color(red: 0, green: 0.64, blue: 0.43))
        .cornerRadius(40)
        .onTapGesture {
            onClicked?()
        }
    }
}
#Preview {
    ButtonView(title: "Start")
}
