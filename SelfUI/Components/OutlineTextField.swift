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
    @State private var imageName: String?
    @FocusState private var isFocused: Bool
    private let label: String
    @Binding private var text: String
    public init(label: String = "Label", imageName: String? = nil, text: Binding<String>) {
        self.label = label
        self.imageName = imageName
        self._text = text
    }
    
    public var body: some View {
        VStack (alignment: .leading) {
            if (!label.isEmpty) {
                Text(label)
                    .font(.defaultCaption)
                    .foregroundColor(.textPrimary)
            } else {
                Spacer(minLength: 8)
            }
            
            ZStack {
                HStack(alignment: .center, spacing: 1) {
                    if let imageName = imageName {
                        Image(imageName, bundle: mainBundle)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: Constants.IconSize, height: Constants.IconSize)
                    }
                    TextField("", text: $emailAddress)
                        .placeholder(when: emailAddress.isEmpty) {
                            Text(text)
                                .font(.defaultBody)
                                .foregroundColor(text.isEmpty ? .defaultPlaceHolder : .textPrimary)
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
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, minHeight: 66, maxHeight: 66, alignment: .leading)
                .background(Color.defaultGray)
                .cornerRadius(.defaultCornerRadius)
                .overlay {
                    RoundedRectangle(cornerRadius: .defaultCornerRadius)
                        .inset(by: 0.5)
                        .stroke(disable ? Color.clear : Color.defaultPink, lineWidth: 1)
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
    ZStack {
        Color.blue.ignoresSafeArea()
        List {
            OutlineTextField(label: "Email address", text: .constant("abbie@company.com"))
                .listRowSeparator(.hidden)
            OutlineTextField(label: "", text: .constant("abbie@company.com"))
                .listRowSeparator(.hidden)
            OutlineTextField(label: "", text: .constant("abbie@company.com"))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            
            OutlineTextField(label: "", imageName: "VN", text: .constant("abbie@company.com"))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
        }
        
        .listRowInsets(.none)
        .listStyle(.insetGrouped)
        .formStyle(.columns)
    }
    
}
