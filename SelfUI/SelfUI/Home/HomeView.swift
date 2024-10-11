//
//  HomeView.swift
//  SelfUI
//
//  Created by Long Pham on 26/8/24.
//

import SwiftUI

struct HomeView: View {
    init() {
    let tabBarAppearance = UITabBarAppearance()
    let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.badgeBackgroundColor =
        UIColor(red: 0.98, green: 0.13, blue: 0.57, alpha: 1.0)
    tabBarAppearance.stackedLayoutAppearance = itemAppearance
    UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    
    var body: some View {
        ZStack {
            TabView {
                MessagingView(title: "Messages")
                    .tabItem {
//                        Label("tab_messaging".localized, systemImage: "plus.message")
                        
                        Label(
                            title: {
                                Text("Label")
                                    .font(.title)
                            },
                            icon: {
                                Image("ic_paperclip", bundle: mainBundle)
                                    .renderingMode(.template)
                            }
                        )
                        
                        
                        
//                        .foregroundColor(selectedTab == tag ? .blue : .gray) // Change color based on selection
                    }.badge("12")
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }.badge("")
                
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
            .tint(Color.defaultBlue)
            
            VStack {
                BannerView(message: "No internet connection")
                Spacer()
            }
            .hidden()
            .transition(.move(edge: .top))
            .animation(.easeInOut, value: true)
        }.ignoresSafeArea()
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
