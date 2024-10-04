//
//  MessageTextCell.swift
//  SelfUI
//
//  Created by Long Pham on 3/10/24.
//

import SwiftUI

struct Constants {
    static let Corner2: CGFloat = 16
    static let Corner3: CGFloat = 12
    static let Corner4: CGFloat = 4
}

struct MessageTextCell: View {
    let message: String
    let isSender: Bool
    let timestamp: String
    init(message: String,
         timestamp: String = "",
         isSender: Bool = true) {
        self.message = message
        self.isSender = isSender
        self.timestamp = timestamp
    }
    var body: some View {
        HStack {
            if isSender {
                Spacer()
            }
            VStack(alignment: isSender ? .trailing : .leading, spacing: 0) {
                Text(message)
                    .multilineTextAlignment(.leading)
                    .font(.defaultBody)
                    .foregroundStyle(Color.textPrimary)
                StatusTimeView(timestamp: timestamp, status: .pending)
            }
            .padding(.horizontal, Constants.Corner2)
            .padding(.vertical, Constants.Corner3)
            .background(isSender ? Color.defaultLightBlue : Color.defaultGray)
            .clipShape(isSender ? .rect(
                topLeadingRadius: Constants.Corner2,
                bottomLeadingRadius: Constants.Corner2,
                bottomTrailingRadius: Constants.Corner4,
                topTrailingRadius: Constants.Corner2
            ) : .rect(
                topLeadingRadius: Constants.Corner2,
                bottomLeadingRadius: Constants.Corner4,
                bottomTrailingRadius: Constants.Corner2,
                topTrailingRadius: Constants.Corner2
            ))
            if !isSender {
                Spacer()
            }
        }
        
    }
}

#Preview {
    ZStack {
        VStack {
            MessageTextCell(message: "Hello there!", timestamp: "now")
            MessageTextCell(message: "Hello there!", isSender: false)
            MessageTextCell(message: "Hi", isSender: true)
            MessageTextCell(message: "Hi", isSender: false)
        }
    }
    
}
