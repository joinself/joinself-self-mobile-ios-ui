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
                VStack {
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
    }
}

#Preview {
    BaseNavigationBarView(title: "Messages")
}
