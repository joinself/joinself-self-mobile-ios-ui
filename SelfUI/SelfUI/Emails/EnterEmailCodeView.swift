//
//  EnterEmailCodeView.swift
//  SelfUI
//
//  Created by Long Pham on 31/7/24.
//

import SwiftUI

struct EnterEmailCodeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    public init(onCode: ((_ code: String) -> Void)? = nil, onResendCode: (() -> Void)? = nil) {
        self.onCode = onCode
        self.onResendCode = onResendCode
    }
    
    var onCode: ((_ code: String) -> Void)?
    var onResendCode: (() -> Void)?
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
            
            PinCodeView(pinLength: 6)
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
            }
            Spacer()
            VStack(spacing: 12) {
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
    EnterEmailCodeView()
}
