//
//  BaseNavigationBarView.swift
//  SelfUI
//
//  Created by Long Pham on 28/9/24.
//

import SwiftUI

public struct BaseNavigationBarView: View {
    let title: String
    var onNavigateBack: (() -> ())?
    public init(title: String, onNavigateBack: (() -> ())? = nil) {
        self.title = title
        self.onNavigateBack = onNavigateBack
    }
    
    public var body: some View {
        VStack {
            HStack {
                VStack (spacing: 4){
                    Spacer()
                    HStack {
                        NavBackButton {
                            onNavigateBack?()
                        }
                        Spacer()
                    }
                    
                    HStack {
                        NavigationTitleView(title: title)
                        Spacer()
                    }
                }
                Spacer()
            }
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
        .background(.white)
        .frame(maxHeight: 110, alignment: .topLeading)
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        BaseNavigationBarView(title: "Messages")
    }
    
}
