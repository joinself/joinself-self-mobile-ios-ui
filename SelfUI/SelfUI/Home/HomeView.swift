//
//  HomeView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            MessagingView()
                .tabItem {
                    Label("tab_messaging".localized, systemImage: "plus.message")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            DataView()
                .tabItem {
                    Label("tab_data".localized, systemImage: "cylinder.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("tab_settings".localized, systemImage: "gearshape")
                }
            
            ScanView()
                .tabItem {
                    Label("tab_scan".localized, systemImage: "qrcode.viewfinder")
                }
        }
    }
}

struct SearchView: View {
    var body: some View {
        NavigationStack {
            Text("Search View")
                .navigationTitle("Search")
        }
    }
}

#Preview {
    HomeView()
}
