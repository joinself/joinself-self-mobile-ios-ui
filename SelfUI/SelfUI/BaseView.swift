//
//  BaseView.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

struct BaseView<Content: View>: View {
    
    let content: Content
    
    @Environment(\.presentationMode) private var presentationMode
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            content
            Spacer()
            VStack(spacing: 12) {
                BrandView(isDarked: true)
            }.padding()
        }
        .background(.white)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavBackButton(isWhiteBackground: false) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    VStack {
        NavigationStack {
            NavigationLink {
                BaseView {
                    Text("Hello Base View")
                }
            } label: {
                Text("Base View")
            }
        }
        
    }
}
