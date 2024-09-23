//
//  LoadingView.swift
//  SelfUI
//
//  Created by Long Pham on 23/9/24.
//

import SwiftUI

public struct LoadingView: View {
    public init () {
        
    }
    
    public var body: some View {
        ZStack {
            Color.defaultOverlay
                .ignoresSafeArea(.all)
            LoadingDotsView()
        }
    }
}

#Preview {
    ZStack {
        //EnterEmailCodeView(showAlert: .constant(false))
        LoadingView()
    }
    
}
