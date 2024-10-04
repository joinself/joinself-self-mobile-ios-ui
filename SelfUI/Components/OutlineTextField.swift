//
//  OutlineTextField.swift
//  SelfUI
//
//  Created by Long Pham on 23/9/24.
//

import SwiftUI

public struct OutlineTextField: View {
    @State private var isValidEmail: Bool = true
    @State private var emailAddress: String = ""
    @State private var disable: Bool = true
    @FocusState private var isFocused: Bool
    private let label: String
    @Binding private var text: String
    public init(label: String = "Label", text: Binding<String>) {
        self.label = label
        self._text = text
    }
    
    public var body: some View {
        VStack (alignment: .leading) {
            Text(label)
                .font(.custom("Barlow", size: 12).weight(.medium))
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
                        .stroke(disable ? Color.clear : Color.defaultPink, lineWidth: 1)
                    TextField("", text: $emailAddress)
                        .placeholder(when: emailAddress.isEmpty) {
                            Text(text)
                                .font(.custom("Barlow", size: 17))
                                .foregroundColor(.defaultPlaceHolder)
                        }
                        .disabled(disable)
                        .accentColor(.defaultBlack) // Set the focus indicator color here
                        .font(.defaultBody)
                        .focused($isFocused)
                        .foregroundColor(.black)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .onChange(of: emailAddress) { newValue in
                            isValidEmail = newValue.isValidEmail()
                        }
                        .onAppear {
                            isFocused = true
                        }
                        .padding()
                }
            }
            
            if !isValidEmail {
                Text("email_address_invalid_message".localized)
                    .foregroundColor(.defaultPink)
            }
        }
    }
}

#Preview {
    OutlineTextField(label: "Email address", text: .constant("abbie@company.com"))
}
