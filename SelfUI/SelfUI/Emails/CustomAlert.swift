//
//  CustomAlert.swift
//  SelfUI
//
//  Created by Long Pham on 2/8/24.
//

import SwiftUI

struct CustomAlertView: View {
    var title: String
    var message: String
    var onOK: (() -> Void)?
    var onCancel: (() -> Void)?
    
    init(title: String, message: String,
         onOK: (() -> Void)? = nil,
         onCancel: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.onOK = onOK
        self.onCancel = onCancel
    }
    
    var body: some View {
        ZStack {
            Color.defaultOverlay.opacity(0.3)
            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .modifier(Heading6TextStyle())
                Text(message)
                    .modifier(Heading6TextStyle())
                HStack (spacing: 40) {
                    Spacer()
                    
                    Button(action: {
                        onCancel?()
                    }, label: {
                        // BUTTON
                        Text("No".localized.uppercased())
                            .modifier(Heading6TextStyle(color: Color.colorPrimary))
                    })
                    
                    Button(action: {
                        onOK?()
                    }, label: {
                        // BUTTON
                        Text("Yes".localized.uppercased())
                            .modifier(Heading6TextStyle(color: Color.colorTextPrimary))
                    })
                }
            }
            .frame(maxWidth: 240)
            .padding(20)
            .background(Color.white)
            .cornerRadius(15)
        }
        .ignoresSafeArea()
    }
}

struct AlertButton: Identifiable {
    let id = UUID()
    var title: String
    var action: () -> Void
}

#Preview {
    CustomAlertView(title: "title", message: "message")
}
