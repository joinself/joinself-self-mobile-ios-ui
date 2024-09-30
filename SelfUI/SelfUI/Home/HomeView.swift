//
//  HomeView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
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
            
            VStack {
                BannerView(message: "No internet connection")
                Spacer()
            }
            .transition(.move(edge: .top))
            .animation(.easeInOut, value: true)
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
