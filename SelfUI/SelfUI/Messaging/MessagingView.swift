//
//  MessagingView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI

struct MessagingView: View {
    var body: some View {
        NavigationStack {
            Text("Messaging View")
                .navigationTitle("tab_messaging".localized)
        }
    }
}

#Preview {
    MessagingView()
}
