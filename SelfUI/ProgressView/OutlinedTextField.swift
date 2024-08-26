//
//  OutlinedTextField.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

struct OutlinedTextField: View {
    @Binding private var isValid: Bool
    @Binding private var text: String
    let placeHolder: String
    let boxLabel: String
    let boxErrorDescription: String
    var textContentType: UITextContentType?
    var autocapitalization: TextInputAutocapitalization?
    var type: UIKeyboardType = .default
    @FocusState private var isFocused: Bool
    init(boxLabel: String, placeHolder: String, boxErrorDescription: String, text: Binding<String>, isValid: Binding<Bool>) {
        self.boxLabel = boxLabel
        self.boxErrorDescription = boxErrorDescription
        self._text = text
        self.placeHolder = placeHolder
        self._isValid = isValid
    }
    var body: some View {
        VStack (alignment: .leading) {
            Text(boxLabel)
                .font(.defaultCaption)
            
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
                        .stroke(isValid ? Color.defaultGreen : Color.defaultPink, lineWidth: 1)
                    TextField("", text: $text)
                        .placeholder(when: text.isEmpty) {
                            Text(placeHolder).foregroundColor(.defaultPlaceHolder)
                        }
                        .accentColor(.defaultBlack) // Set the focus indicator color here
                        .font(.defaultBody)
                        .focused($isFocused)
                        .foregroundColor(.black)
                        .textContentType(textContentType)
                        .textInputAutocapitalization(autocapitalization)
                        .keyboardType(type)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                isFocused = true
                            }
                            
                        }
                        .padding()
                }
            }
            
            if !isValid {
                Text(boxErrorDescription)
                    .foregroundColor(.defaultPink)
            }
        }.padding()
    }
}

#Preview {
    OutlinedTextField(boxLabel: "Label", placeHolder: "Place Holder", boxErrorDescription: "This field cannot be empty.", text: .constant(""), isValid: .constant(false))
}
