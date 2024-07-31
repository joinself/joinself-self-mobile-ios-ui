//
//  EnterEmailView.swift
//  SelfUI
//
//  Created by Long Pham on 31/7/24.
//

import SwiftUI

struct EnterEmailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    public init(onAccept: (() -> Void)? = nil) {
        self.onAccept = onAccept
    }
    
    var onAccept: (() -> Void)?
    @State private var isValidEmail: Bool = false
    @State private var emailAddress: String = ""
    
    public var body: some View {
        VStack {
            // stepped progress view
            CustomProgressView(steps: [
                Step(title: "1", state: .done),
                Step(title: "2", state: .done),
                Step(title: "3", state: .done),
                Step(title: "4", state: .active),
                Step(title: "5", state: .inactive)
            ])
            
            Text("enter_email_title".localized)
                .font(.defaultTitle)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                .padding(.all, 16)
            
            VStack (alignment: .leading) {
                Text("email_address".localized)
                    .font(.defaultBody)
                    .bold()
                    .foregroundColor(.black)
                
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
                            .stroke(isValidEmail ? Color.defaultBlue : Color.defaultPink, lineWidth: 1)
                        TextField("", text: $emailAddress)
                            .placeholder(when: emailAddress.isEmpty) {
                                Text("email_address_placeholder".localized).foregroundColor(.defaultPlaceHolder)
                            }
                            .font(.defaultBody)
                            .foregroundColor(.black)
                            .textContentType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .onChange(of: emailAddress) { newValue in
                                isValidEmail = newValue.isValidEmail()
                            }
                            .padding()
                    }
                }
                
                if !isValidEmail {
                    Text("email_address_invalid_message".localized)
                        .foregroundColor(.defaultPink)
                }
            }.padding()
            
            Spacer()
            VStack(spacing: 12) {
                if isValidEmail {
                    ButtonView(title: "button_send_code".localized) {
                        onAccept?()
                    }
                } else {
                    ButtonView(title: "button_send_code".localized, backgroundColor: .defaultGray) {
                        
                    }
                }
                
                
                BrandView(isDarked: true)
            }.padding()
        }
        .background(.white)
        .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image("ic_back_dark", bundle: mainBundle)
                        }
                    }
                }
            }
    }
}

#Preview {
    EnterEmailView()
}
