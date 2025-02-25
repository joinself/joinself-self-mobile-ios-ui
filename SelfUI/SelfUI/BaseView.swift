//
//  BaseView.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

struct BaseView<Content: View>: View {
    
    let content: Content
    let enableBackNavigation: Bool
    
    @Environment(\.presentationMode) private var presentationMode
    init(enableBackNavigation: Bool = true, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.enableBackNavigation = enableBackNavigation
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 12) {
            VStack {
                Spacer()
                content
//                    .padding(Constants.EdgeInsetsDefault)
            }
            HStack (alignment: .bottom) {
                BrandView(isDarked: true)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if enableBackNavigation {
                    NavBackButton(isWhiteBackground: false) {
                        presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    BaseView {
        Text("Hello Base View")
    }
}
