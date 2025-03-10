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
    var completion: (() -> Void)?
    
    init(title: String, message: String, completion: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.completion = completion
    }
    
    var body: some View {
        VStack(spacing: 10) {
//            Text(title)
//                .font(.headline)
            Image("ic_multiply_circle", bundle: mainBundle)
            Text("Code Not Recognised")
              .font(
                Font.custom("SF Pro", size: 17)
                  .weight(.semibold)
              )
              .multilineTextAlignment(.center)
              .foregroundColor(.black)
//              .frame(width: 191, height: 20, alignment: .center)
//            Text(message)
//                .font(.subheadline)
            Text("Try Again")
              .font(Font.custom("SF Pro", size: 13))
              .multilineTextAlignment(.center)
              .foregroundColor(.black)
//              .frame(width: 191, height: 20, alignment: .center)
            Button(action: {
                completion?()
            }, label: {
                Text("Enter Code Again")
                  .font(
                    Font.custom("SF Pro", size: 15)
                      .weight(.semibold)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.17, green: 0.49, blue: 0.96))
//                  .frame(width: 191, height: 20, alignment: .center)
            })
            
            Button(action: {
                print("Clicked.")
                completion?()
            }, label: {
                Text("Cancel".localized)
                  .font(Font.custom("SF Pro", size: 13))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.17, green: 0.49, blue: 0.96))
//                  .frame(width: 191, height: 20, alignment: .center)
            })
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
    CustomAlertView(title: "title", message: "message")
}
