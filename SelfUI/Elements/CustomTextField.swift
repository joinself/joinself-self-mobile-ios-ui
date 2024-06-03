//
//  CustomTextField.swift
//  SelfUI
//
//  Created by Long Pham on 3/6/24.
//

import SwiftUI

class CustomTextFieldViewModel: ObservableObject {
    @Published var label: String = ""
    @Published var placeHolder: String = ""
    @Published var text: String = ""
}

struct CustomTextField: View {
    @ObservedObject var viewModel = CustomTextFieldViewModel()
    init(label: String, placeHolder: String, text: Binding<String>) {
        self.viewModel.label = label
        self.viewModel.placeHolder = placeHolder
        self.viewModel.text = text.wrappedValue
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(viewModel.label)
                .font(.callout)
                .bold()
            TextField(viewModel.placeHolder, text: $viewModel.text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

//#Preview {
//    
//    CustomTextField(label: "Passport number", placeHolder: "ddmmyy", text: CustomTextFieldViewModel().text)
//}
