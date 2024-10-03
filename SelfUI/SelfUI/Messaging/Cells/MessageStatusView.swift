//
//  MessageStatusView.swift
//  SelfUI
//
//  Created by Long Pham on 3/10/24.
//

import SwiftUI

struct MessageStatusView: View {
    var body: some View {
        HStack {
            // Caption/Regular
            Text("13:00")
              .font(Font.custom("Plus Jakarta Sans", size: 12))
              .multilineTextAlignment(.trailing)
              .foregroundColor(Color(red: 0.54, green: 0.54, blue: 0.54))
            Image("ic_message_delivered", bundle: mainBundle)
              .frame(width: 28, height: 28)
        }
    }
}

#Preview {
    MessageStatusView()
}
