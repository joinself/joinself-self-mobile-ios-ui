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
    var buttons: [AlertButton]
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.headline)
            Text(message)
                .font(.subheadline)
            ForEach(buttons) { button in
                Button(action: button.action) {
                    Text(button.title)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

struct AlertButton: Identifiable {
    let id = UUID()
    var title: String
    var action: () -> Void
}

#Preview {
    CustomAlertView(title: "title", message: "message", buttons: [
        AlertButton(title: "Button 1", action: { print("Button 1 pressed") }),
        AlertButton(title: "Button 2", action: { print("Button 2 pressed") }),
        AlertButton(title: "Button 3", action: { print("Button 3 pressed") })
    ])
}
