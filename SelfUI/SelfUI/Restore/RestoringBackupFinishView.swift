//
//  RestoringBackupFinishView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct RestoringBackupFinishView: View, BaseActions {
    var onNext: (() -> Void)?
    
    public init(onNext: (() -> Void)? = nil) {
        self.onNext = onNext
    }
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 6, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text("title_restore_backup_finish_intro".localized)
                    .font(.defaultLargeTitle)
                    .foregroundColor(.textPrimary)
                Text("msg_restore_backup_finish_intro".localized)
                    .font(Font.defaultBody)
                  .lineSpacing(1.14)
                  .foregroundColor(.textPrimary)
                Spacer()
                ButtonView(title: "button_turn_on_notifications".localized) {
                    PermissionHelper.requestNotificationPermission { success in
                        onNext?()
                    }
                }
            }
        })
    }
}

#Preview {
    RestoringBackupFinishView()
}
