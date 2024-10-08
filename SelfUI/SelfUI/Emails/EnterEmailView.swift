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
    @State private var editFieldState: OutlineTextFieldState = .initial
    
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
                    
                    Spacer(minLength: 50)
                    
                    Text("enter_email_title".localized)
                        .font(.defaultTitle)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Spacer(minLength: 30)
                    
                    OutlineLabelTextField(label: "email_address".localized, placeHolder: "email_address_placeholder".localized,
                                          errorDescription: "email_address_invalid_message".localized,
                                          keyboardType: .emailAddress,
                                          textInputAutocapitalization: .never,
                                          state: $editFieldState, text: $emailAddress, isFocused: _isFocused)
                    .onChange(of: emailAddress) { newValue in
                        isValidEmail = newValue.isValidEmail()
                        
                        editFieldState = isValidEmail ? .valid : .error
                    }
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
        .padding()
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
