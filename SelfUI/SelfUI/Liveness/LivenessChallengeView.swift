//
//  LivenessChallengeView.swift
//  SelfUI
//
//  Created by Long Pham on 14/5/24.
//

import SwiftUI

public struct LivenessChallengeView: View {
    
    @Binding var message: String
    public init(message: Binding<String>) {
        self._message = message
    }
    
    public var body: some View {
        VStack (alignment: .center) {
            Spacer()
            ZStack {
                //                Image("bg_turn_left", bundle: mainBundle)
                Text(message)
                    .modifier(Heading4TextStyle())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    )
                    .padding()
                
            }
        }
    }
}

#Preview {
    VStack {
        LivenessChallengeView(message: .constant("Move Closer"))
        LivenessChallengeView(message: .constant("Move Further Away"))
    }
    .background(.gray)
}
