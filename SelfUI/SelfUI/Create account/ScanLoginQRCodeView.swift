//
//  ScanLoginQRCodeView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI

struct ScanLoginQRCodeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    public init(callback: (() -> Void)? = nil) {
        self.callback = callback
    }
    
    var callback: (() -> Void)?
    
    public var body: some View {
        VStack {
            // stepped progress view
            CustomProgressView(steps: [
                Step(title: "1", state: .done),
                Step(title: "2", state: .done),
                Step(title: "3", state: .done),
                Step(title: "4", state: .done),
                Step(title: "5", state: .done)
            ])
            
            Spacer(minLength: 50)
            VStack(alignment: .leading, spacing: 30) {
                Text("scan_login_qr_code_body".localized)
                    .font(.defaultTitle)
                    .foregroundColor(.black)
                
                // Heading/H4
                Text("https://portal.joinself.com")
                  .font(
                    Font.custom("Barlow", size: 25)
                      .weight(.bold)
                  )
                  .tint(.defaultGreen)
                  .foregroundColor(.defaultGreen)
                  .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
            VStack(spacing: 12) {
                ButtonView(title: "button_scan_qr_code".localized) {
                    callback?()
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
                    NavBackButton()
                }
            }
        }
    }
}

#Preview {
    ScanLoginQRCodeView()
}
