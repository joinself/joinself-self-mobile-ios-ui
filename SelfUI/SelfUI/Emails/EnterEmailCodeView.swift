//
//  EnterEmailCodeView.swift
//  SelfUI
//
//  Created by Long Pham on 31/7/24.
//

import SwiftUI

public struct EnterEmailCodeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding private var showAlert: Bool
    @State private var pinCode: [String] = Array(repeating: "", count: 6)
    
    
    public init(showAlert: Binding<Bool>, onCode: ((_ code: String) -> Void)? = nil, onResendCode: (() -> Void)? = nil) {
        self._showAlert = showAlert
        self.onCode = onCode
        self.onResendCode = onResendCode
    }
    
    var onCode: ((_ code: String) -> Void)?
    var onResendCode: (() -> Void)?
    @State private var isValidEmail: Bool = false
    @State private var emailAddress: String = ""
    
    public var body: some View {
        ZStack {
            VStack {
                // stepped progress view
                CustomProgressView(steps: [
                    Step(title: "1", state: .done),
                    Step(title: "2", state: .done),
                    Step(title: "3", state: .done),
                    Step(title: "4", state: .active),
                    Step(title: "5", state: .inactive)
                ])
                
                Text("email_enter_code_title".localized)
                    .font(.defaultTitle)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    .padding(.all, 16)
                
                PinCodeView(pinLength: 6, pinCode: $pinCode) { code in
                    self.onCode?(code)
                }
                HStack {
                    Image("ic_resend", bundle: mainBundle)
                    // Paragraph/Caption
                    Text("resend_code".localized)
                        .font(
                            Font.defaultBody
                        )
                        .foregroundColor(.defaultBlue)
                }.onTapGesture {
                    onResendCode?()
                    pinCode = Array(repeating: "", count: 6)
                }

                Spacer()
                VStack(spacing: 12) {
                    BrandView(isDarked: true)
                }.padding()
            }
            
            if showAlert {
                CustomAlertView(title: "", message: "") {
                    showAlert = false
                    pinCode = Array(repeating: "", count: 6)
                }
//                .frame(width: 350, height: 200)
                .onTapGesture {
                    showAlert = false
                }
            }
        }
//        .alert(isPresented: $showAlert) {
//            Alert(title: Text("email_code_not_recognized".localized), message: Text("try_again".localized), dismissButton: .default(Text("enter_code_again".localized), action: {
//                showAlert = false
//                pinCode = Array(repeating: "", count: 6)
//            })
//            )
//        }
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
    EnterEmailCodeView(showAlert: .constant(false))
}
