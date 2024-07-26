//
//  PagingView.swift
//  SelfUI
//
//  Created by Long Pham on 26/7/24.
//

import SwiftUI

struct PagingView: View {
    let totalPage = 4
    @State private var selectedTab = 0
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                Text("First View")
                    .tabItem {
                        Label("First", systemImage: "1.circle")
                    }
                    .tag(0)
                
                Text("Second View")
                    .tabItem {
                        Label("Second", systemImage: "2.circle")
                    }
                    .tag(1)
                
                Text("Third View")
                    .tabItem {
                        Label("Third", systemImage: "3.circle")
                    }
                    .tag(2)
                
                Text("Third View")
                    .tabItem {
                        Label("Third", systemImage: "3.circle")
                    }
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer()
            VStack (spacing: 16) {
                CustomPageIndicator(currentIndex: selectedTab, total: totalPage)
                ButtonView(title: "button_next".localized, backgroundColor: .defaultGreen) {
                    if self.selectedTab < totalPage {
                        self.selectedTab += 1
                    } else {
                        self.selectedTab = 0
                    }
                }
                BrandView(isDarked: true)
            }.padding()
        }
        
    }
}

struct PagingView_Previews: PreviewProvider {
    static var previews: some View {
        PagingView()
    }
}
