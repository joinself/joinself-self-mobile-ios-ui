//
//  LivenessChallengeView.swift
//  SelfUI
//
//  Created by Long Pham on 14/5/24.
//

import SwiftUI

public struct LivenessChallengeView: View {
    
    @Binding var message: String
    @Binding var position: Position
    public init(message: Binding<String>, position: Binding<Position>) {
        self._message = message
        self._position = position
    }
    
    public var body: some View {
        VStack (alignment: .center) {
            Spacer()
            ZStack {
                backgroundView(for: position)
                    .overlay {
                        Text(message)
                            .modifier(Heading4TextStyle())
                            .padding()
                            .padding()
                            //.frame(maxWidth: .infinity)
                    }
            }
        }
    }
    
    @ViewBuilder
    private func backgroundView(for position: Position) -> some View {
        switch position {
        case .none:
            Image("selfie_tip_background", bundle: mainBundle)
        case .left:
            Image("bg_turn_left", bundle: mainBundle)
        case .right:
            Image("bg_turn_right", bundle: mainBundle)
        case .up:
            Image("bg_lookup", bundle: mainBundle)
            
        case .down:
            Image("bg_lookdown", bundle: mainBundle)
        }
    }
}

#Preview {
    VStack {
        LivenessChallengeView(message: .constant("Please position your face inside the frame"), position: .constant(.none))
        LivenessChallengeView(message: .constant("Left"), position: .constant(.left))
        LivenessChallengeView(message: .constant("Right"), position: .constant(.right))
        LivenessChallengeView(message: .constant("Up"), position: .constant(.up))
        LivenessChallengeView(message: .constant("Down"), position: .constant(.down))
    }
    .background(.gray)
}
