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
                List {
                    MessageListCell()
                    MessageListCell()
                }
                .listStyle(.plain)
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image("ic_back_dark", bundle: mainBundle)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MessagingView(title: "Messages")
}
