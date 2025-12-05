//
//  BackupDoneView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct BackupErrorView: View {
    
    var onAction: (() -> Void)?
    var onBack: (() -> Void)?
    
    let errorMessage: String?
    
    public init(errorMessage: String? = nil, onAction: (() -> Void)? = nil, onBack: (() -> Void)? = nil) {
        self.onAction = onAction
        self.onBack = onBack
        self.errorMessage = errorMessage
    }
    
    public var body: some View {
        BaseView (onBack: {
            onBack?()
        }, content: {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Backup failed!")
                        .modifier(Heading1TextStyle())
                        .padding(.top, Constants.Heading1PaddingTop)
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .modifier(Body1TextStyle())
                    }
                    
                    Spacer()
                    ButtonView(title: "button_try_again".localized) {
                        onAction?()
                    }
                }
            }
        })
    }
}

#Preview {
    BackupErrorView(errorMessage: "Backup failed.")
}
