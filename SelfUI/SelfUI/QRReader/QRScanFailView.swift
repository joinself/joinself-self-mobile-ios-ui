//
//  QRScanFailView.swift
//  SelfUI
//
//  Created by Long Pham on 5/10/24.
//

import SwiftUI

public struct QRScanFailView: View {
    @Environment(\.presentationMode) var presentationMode
    var onRetry: (() -> ())?
    var onExit: (() -> ())?
    public init(onRetry: (() -> Void)? = nil, onExit: (() -> ())? = nil) {
        self.onRetry = onRetry
        self.onExit = onExit
    }
    
    public var body: some View {
        NavigationStack(root: {
            VStack {
                HStack {
                    NavBackButton(isWhiteBackground: false) {
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
                .padding()
                Spacer()
                Text("message_scan_fail".localized).font(.defaultLargeTitle)
                    .minimumScaleFactor(0.7)
                    .foregroundStyle(Color.textPrimary)
                Spacer()
                VStack(spacing: 12) {
                    ButtonView(title: "button_try_again".localized) {
                        onRetry?()
                    }
                    
                    ButtonView(title: "button_exit_scanner".localized, backgroundColor: .defaultPink) {
                        onExit?()
                    }
                    
                    BrandView(isDarked: true)
                }
            }
            .padding()
            .background(Color.white)
        })
        .background(Color.white)
        .ignoresSafeArea()
        
    }
}

#Preview {
    QRScanFailView()
}
