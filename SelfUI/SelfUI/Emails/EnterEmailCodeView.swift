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
    }
}

#Preview {
    EnterEmailCodeView(showAlert: .constant(false))
}
