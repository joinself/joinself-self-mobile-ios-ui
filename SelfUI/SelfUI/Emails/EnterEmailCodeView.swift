//
//  EnterEmailCodeView.swift
//  SelfUI
//
//  Created by Long Pham on 31/7/24.
//

import SwiftUI

public struct EnterEmailCodeView: View {
    @Binding private var showAlert: Bool
    @State private var pinCode: [String] = Array(repeating: "", count: 6)
    private var onCancel: (() -> Void)?
    
    public init(showAlert: Binding<Bool>,
                onCode: ((_ code: String) -> Void)? = nil, onResendCode: (() -> Void)? = nil,
                onCancel: (() -> Void)? = nil) {
        self._showAlert = showAlert
        self.onCode = onCode
        self.onResendCode = onResendCode
        self.onCancel = onCancel
    }
    
    var onCode: ((_ code: String) -> Void)?
    var onResendCode: (() -> Void)?
    @State private var isValidEmail: Bool = false
    @State private var emailAddress: String = ""
    
    public var body: some View {
        ZStack {
        
            BaseProgressView (totalSteps: 6, activeStep: 2, content: {
                ScrollView {
                    VStack (alignment: .leading) {
                        Text("email_enter_code_title".localized)
                            .modifier(Heading3TextStyle())
                            .padding(.top, Constants.Heading1PaddingTop)
                        
                        PinCodeView(pinLength: 6, pinCode: $pinCode) { code in
                            self.onCode?(code)
                        }
                        HStack {
                            Spacer()
                            Button {
                                onResendCode?()
                                pinCode = Array(repeating: "", count: 6)
                            } label: {
                                HStack {
                                    Image("ic_resend", bundle: mainBundle)
                                    // Paragraph/Caption
                                    Text("resend_code".localized)
                                        .font(
                                            Font.defaultBody
                                        )
                                        .foregroundColor(.defaultBlue)
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
                
            })
            
            if showAlert {
                CustomAlertView(title: "email_code_not_recognized".localized, message: "try_again".localized) {
                    showAlert = false
                    pinCode = Array(repeating: "", count: 6)
                } onCancel: {
                    print("Cancel email flow.")
                    onCancel?()
                }
                .onTapGesture {
                    showAlert = false
                }
            }
        }
    }
}

#Preview {
    EnterEmailCodeView(showAlert: .constant(true))
}
