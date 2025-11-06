//
//  BaseView.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

public struct BaseView<Content: View>: View {
    
    let content: Content
    let enableBackNavigation: Bool
    let backgroundColor: Color
    let brandTextColor: Color
    private var onBack: (() -> Void)?
    
    @Environment(\.presentationMode) private var presentationMode
    public init(enableBackNavigation: Bool = true,     backgroundColor: Color = .white,
         brandTextColor: Color = .colorTextPrimary,
         onBack: (() -> Void)? = nil,
         @ViewBuilder content: () -> Content) {
        self.content = content()
        self.enableBackNavigation = enableBackNavigation
        self.onBack = onBack
        self.backgroundColor = backgroundColor
        self.brandTextColor = brandTextColor
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 12) {
            VStack {
                Spacer()
                content
            }
            HStack (alignment: .bottom) {
                BrandView(isDarked: true, textColor: brandTextColor)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            if #available(iOS 26.0, *) {
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
                .sharedBackgroundVisibility(.hidden)
            } else {
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
}

#Preview {
    BaseView {
        Text("Hello Base View")
    }
}
