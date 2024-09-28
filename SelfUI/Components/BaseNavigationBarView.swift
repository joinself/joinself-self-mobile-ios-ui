//
//  BaseNavigationBarView.swift
//  SelfUI
//
//  Created by Long Pham on 28/9/24.
//

import SwiftUI

public struct BaseNavigationBarView: View {
    let title: String
    public init(title: String) {
        self.title = title
    }
    
    public var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        NavBackButton {
                            
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
    }
}

#Preview {
    BaseNavigationBarView(title: "Messages")
}
