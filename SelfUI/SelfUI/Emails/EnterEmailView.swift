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
        ScrollViewReader { proxy in
            BaseProgressView (totalSteps: 6, activeStep: 1, content: {
                ScrollView {
                    VStack (alignment: .leading, spacing: 30) {
                        Text("enter_email_title".localized)
                            .modifier(Heading3TextStyle())
                            
                        OutlineLabelTextField(label: "email_address".localized, placeHolder: "email_address_placeholder".localized,
                                              errorDescription: "email_address_invalid_message".localized,
                                              keyboardType: .emailAddress,
                                              textInputAutocapitalization: .never,
                                              state: $editFieldState, text: $emailAddress, isFocused: _isFocused)
                        .onChange(of: emailAddress) { newValue in
                            isValidEmail = newValue.isValidEmail()
                            
                            editFieldState = isValidEmail ? .valid : .error
                            withAnimation {
                                // `1` is the id of the view that scroll to
                                proxy.scrollTo(1, anchor: .bottom)
                            }
                        }
                    }.id(1)
                }
                
                if isValidEmail {
                    ButtonView(title: "button_send_code".localized) {
                        onFinish?(emailAddress)
                    }
                } else {
                    ButtonView(title: "button_send_code".localized, backgroundColor: .defaultGray) {
                        
                    }
                }
                
            })
            
        }.scrollDismissesKeyboard(.interactively) // This dismisses the keyboard interactively
//        .padding()
//        .scrollDismissesKeyboard(.interactively) // This dismisses the keyboard interactively
//        .background(.white)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    HStack {
//                        Image("ic_back_dark", bundle: mainBundle)
//                    }
//                }
//            }
//        }
    }
}

#Preview {
    EnterEmailView()
}
