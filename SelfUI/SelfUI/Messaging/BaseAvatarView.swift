//
//  BaseAvatarView.swift
//  SelfUI
//
//  Created by Long Pham on 6/3/25.
//

import SwiftUI

public struct BaseAvatarView<Content: View>: View {
    
    let content: Content
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        Circle()
          .foregroundStyle(Color.colorPrimary)
          .overlay {
              content
          }
    }
}

#Preview {
    VStack {
        BaseAvatarView {
            Image("ic_self_logo", bundle: mainBundle)
        }
        .frame(width: 40, height: 40)
        
        BaseAvatarView {
            Image("ic_self_pink", bundle: mainBundle)
        }
        .frame(width: 40, height: 40)
        
        BaseAvatarView {
            Text("S2")
                .modifier(Body1TextStyle(color: .colorTextSecondary))
        }
        .frame(width: 80, height: 80)
        
        BaseAvatarView {
            Text("S1")
                .modifier(Body1TextStyle(color: .colorTextSecondary))
        }
        .frame(width: 40, height: 40)
    }
}
