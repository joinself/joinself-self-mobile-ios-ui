//
//  BackupInfoView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct BackupInfoView: View {
    
    public init(onGettingStarted: @escaping () -> Void, onNavigateBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigateBack = onNavigateBack
    }
    
    private var onGettingStarted: () -> Void
    private var onNavigateBack: () -> Void
    private var onSelectNegative: (() -> Void)? = nil
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        BaseView {
            VStack(alignment: .leading, spacing: 30) {
                Text("title_backup".localized)
                    .font(.defaultLargeTitle)
                    .foregroundColor(.textPrimary)
                Text("msg_backup".localized)
                    .font(Font.defaultBody)
                  .lineSpacing(1.14)
                  .foregroundColor(.black)
                Spacer()
            }
            .padding(EdgeInsets(top: 50, leading: 24, bottom: 10, trailing: 24))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ButtonView(title: "button_backup_now".localized) {
                onGettingStarted()
            }
        }
    }
}

#Preview {
    BackupInfoView(onGettingStarted: {
        
    }, onNavigateBack: {
        
    })
}
