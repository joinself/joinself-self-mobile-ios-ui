//
//  BackupDoneView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct BackupDoneView: View {
    
    public init(onGettingStarted: @escaping () -> Void, onNavigateBack: @escaping () -> Void) {
        self.onGettingStarted = onGettingStarted
        self.onNavigateBack = onNavigateBack
    }
    
    var onGettingStarted: () -> Void
    var onNavigateBack: () -> Void
    public var onSelectNegative: (() -> Void)? = nil
    
    public var body: some View {
        BaseView {
            VStack(alignment: .leading, spacing: 30) {
                Text("title_backup_done".localized)
                    .font(.defaultLargeTitle)
                    .foregroundColor(.textPrimary)
                Spacer()
            }
            .padding(EdgeInsets(top: 50, leading: 24, bottom: 10, trailing: 24))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
            ButtonView(title: "button_done".localized) {
                onGettingStarted()
            }
        }
    }
}

#Preview {
    BackupDoneView(onGettingStarted: {
        
    }, onNavigateBack: {
        
    })
}
