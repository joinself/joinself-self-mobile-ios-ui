//
//  SettingsView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            Text("Settings View")
                .navigationTitle("tab_settings".localized)
        }
    }
}

#Preview {
    SettingsView()
}
