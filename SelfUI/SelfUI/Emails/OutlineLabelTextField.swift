//
//  OutlineLabelTextField.swift
//  SelfUI
//
//  Created by Long Pham on 8/10/24.
//

import SwiftUI

enum OutlineTextFieldState: String, CaseIterable {
    case initial
    case valid // ex: valid email address, phone number
    case error
    
    func getColor() -> Color {
        switch self {
        case .initial:
            return .defaultBlue
        case .valid:
            return .defaultGreen
        case .error:
            return .defaultError
        }
    }
}

struct OutlineLabelTextField: View {
    @Binding private var state: OutlineTextFieldState
    @Binding private var text: String
    @FocusState private var isFocused: Bool
    let label: String
    let placeHolder: String
    let errorDescription: String
    let keyboardType: UIKeyboardType
    let textContentType: UITextContentType
    let textInputAutocapitalization: TextInputAutocapitalization
    
    init(label: String,
         placeHolder: String,
         errorDescription: String,
         keyboardType: UIKeyboardType = .default,
         textContentType: UITextContentType = .emailAddress,
         textInputAutocapitalization: TextInputAutocapitalization = .never,
         state: Binding<OutlineTextFieldState>,
         text: Binding<String>,
         isFocused: Bool = true) {
        self.label = label
        self.placeHolder = placeHolder
        self.errorDescription = errorDescription
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.textInputAutocapitalization = textInputAutocapitalization
        self._state = state
        self._text = text
        self.isFocused = isFocused
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label)
                .font(.defaultFieldLabel)
                .foregroundColor(.textPrimary)
            
            ZStack {
                HStack(alignment: .center, spacing: 1) {
                    
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, minHeight: 66, maxHeight: 66, alignment: .leading)
                .background(Color.defaultGray)
                .cornerRadius(.defaultCornerRadius)
                .overlay {
                    RoundedRectangle(cornerRadius: .defaultCornerRadius)
                        .inset(by: 0.5)
                        .stroke(state.getColor(),
                            lineWidth: 1)
                    TextField("", text: $text)
                        .placeholder(when: text.isEmpty) {
                            Text(placeHolder).foregroundColor(.defaultPlaceHolder)
                        }
                        .accentColor(.defaultBlack) // Set the focus indicator color here
                        .font(.defaultBody)
                        .focused($isFocused)
                        .foregroundColor(.textPrimary)
                        .textContentType(textContentType)
                        .textInputAutocapitalization(textInputAutocapitalization)
                        .keyboardType(keyboardType)
                        /*.onChange(of: text) { newValue in
                            if newValue.isValidEmail() {
                                state = .valid
                            }
                        }*/
                        .onAppear {
                            isFocused = true
                        }
                        .padding()
                }
            }
            
            if state == .error {
                Text(errorDescription)
                    .foregroundColor(.defaultPink)
            }
        }.padding()
    }
}

#Preview {
    VStack {
        OutlineLabelTextField(label: "Email Address", placeHolder: "Enter email address",
                              errorDescription: "email_address_invalid_message".localized,
                              state: .constant(.initial), text: .constant(""), isFocused: false)
        OutlineLabelTextField(label: "Email Address", placeHolder: "Enter phone number",
                              errorDescription: "email_address_invalid_message".localized,
                              state: .constant(.error), text: .constant(""), isFocused: false)
        OutlineLabelTextField(label: "Email Address", placeHolder: "Enter your name",
                              errorDescription: "email_address_invalid_message".localized,
                              state: .constant(.valid), text: .constant(""), isFocused: false)
    }
    
}
