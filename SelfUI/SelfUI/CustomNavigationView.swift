//
//  BaseNavigationView.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

struct CustomNavigationView<NavigationContent: ToolbarContent, BodyContent: View>: View {
    
    let content: BodyContent
    let navigationContent: NavigationContent
    
    @Environment(\.presentationMode) private var presentationMode
    init(@ToolbarContentBuilder navigationContent: () -> NavigationContent, @ViewBuilder content: () -> BodyContent) {
        self.content = content()
        self.navigationContent = navigationContent()
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 12) {
            VStack {
                Spacer()
                content
            }
            HStack (alignment: .bottom) {
                BrandView(isDarked: true)
            }
        }
        .padding(Constants.EdgeInsetsDefault)
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            navigationContent
        }
    }
}

#Preview {
    NavigationView {
        CustomNavigationView {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    
                } label: {
                    Text("Recover Account")
                }
            }
        } content: {
            Text("Base Navigation View")
        }
    }
}
