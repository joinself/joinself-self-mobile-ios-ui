//
//  ProfileView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            Text("Profile View")
                .navigationTitle("tab_profile".localized)
        }
    }
}

#Preview {
    ProfileView()
}
