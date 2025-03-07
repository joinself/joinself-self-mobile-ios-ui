//
//  MessagingView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI

public struct MessagingView: View {
    let title: String
    
    init(title: String = "") {
        self.title = title
    }
    
    public var body: some View {
        NavigationStack {
            VStack {
//                NavigationTitleView(title: title)
                List {
//                    MessageListCell()
//                        .listRowInsets(.none)
                }
                .listStyle(.plain)
            }
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    BaseNavigationBarView(title: title)
//                }
//            }
        }
    }
}

#Preview {
    MessagingView(title: "Messages")
}
