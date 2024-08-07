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
    @Environment(\.presentationMode) var presentationMode
    
    var onFinish: ((Bool) -> Void)?
    init(selectedTab: Int = 0, onFinish: ( (Bool) -> Void)? = nil) {
        self.selectedTab = selectedTab
        self.onFinish = onFinish
    }
    
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
                if selectedTab < 3 {
                    ButtonView(title: "button_next".localized, backgroundColor: .defaultGreen) {
                        if self.selectedTab < totalPage {
                            self.selectedTab += 1
                        } else {
                            self.selectedTab = 0
                        }
                    }
                } else {
                    ButtonView(title: "button_joinself".localized, backgroundColor: .defaultPink) {
                        // TODO: JoinSelf
                        onFinish?(true)
                    }
                }
                
                BrandView(isDarked: true)
                
            }.padding()
        }
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image("ic_back_dark", bundle: mainBundle)
                    }
                }
            }
        }
    }
}

struct PagingView_Previews: PreviewProvider {
    static var previews: some View {
        PagingView()
    }
}
