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
                PageContentView(title: "secure_communication_title".localized, description: "secure_communication_description".localized)
                    .tag(0)
                
                PageContentView(title: "control_data_title".localized, description: "control_data_description".localized)
                    .tag(1)
                PageContentView(title: "start_self_today_title".localized, description: "start_self_today_description".localized)
                    .tag(2)
                PageContentView(title: "the_really_important_bit_title".localized, description: "the_really_important_bit_description".localized)
                    .tag(3)
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
