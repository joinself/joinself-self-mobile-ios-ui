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
    private var onBack: (() -> Void)?
    
    @Environment(\.presentationMode) private var presentationMode
    init(enableBackNavigation: Bool = true, onBack: (() -> Void)? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.enableBackNavigation = enableBackNavigation
        self.onBack = onBack
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
                        onBack?() // on some cases the presentation mode does not dismiss the modal view. Show we need to handle it on parent view
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
