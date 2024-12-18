//
//  BackupInfoView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct BackupInfoView: View {
    
    @Binding var isNetworkConnected: Bool
    public init(isNetworkConnected: Binding<Bool> = .constant(true), onGettingStarted: @escaping () -> Void, onNavigateBack: @escaping () -> Void) {
        self._isNetworkConnected = isNetworkConnected
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
                  .foregroundColor(.textPrimary)
                Spacer()
                
                ButtonView(title: "button_backup_now".localized, isActive: $isNetworkConnected) {
                    onGettingStarted()
                }
            }
        }
    }
}

#Preview {
    BackupInfoView(isNetworkConnected: .constant(false), onGettingStarted: {
        
    }, onNavigateBack: {
        
    })
}
