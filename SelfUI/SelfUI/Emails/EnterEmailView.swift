//
//  EnterEmailView.swift
//  SelfUI
//
//  Created by Long Pham on 31/7/24.
//

import SwiftUI

struct EnterEmailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    public init(onFinish: ((_ email: String) -> Void)? = nil) {
        self.onFinish = onFinish
    }
    
    var onFinish: ((_ email: String) -> Void)?
    @State private var isValidEmail: Bool = false
    @State private var emailAddress: String = ""
    @FocusState private var isFocused: Bool
    
    public var body: some View {
        VStack {
            ScrollView {
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
                                    .stroke(isValidEmail ? Color.defaultGreen : Color.defaultPink, lineWidth: 1)
                                TextField("", text: $emailAddress)
                                    .placeholder(when: emailAddress.isEmpty) {
                                        Text("email_address_placeholder".localized).foregroundColor(.defaultPlaceHolder)
                                    }
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
                    }.padding()
                    
                }
                
            }
            
            Spacer()
            VStack(spacing: 12) {
                if isValidEmail {
                    ButtonView(title: "button_send_code".localized) {
                        onFinish?(emailAddress)
                    }
                } else {
                    ButtonView(title: "button_send_code".localized, backgroundColor: .defaultGray) {
                        
                    }
                }
                
                
                BrandView(isDarked: true)
            }
        }
        .scrollDismissesKeyboard(.interactively) // This dismisses the keyboard interactively
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
