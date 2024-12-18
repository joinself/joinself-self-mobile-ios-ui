//
//  RestoringBackupView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct RestoringBackupView: View, BaseActions {
    var onNext: (() -> Void)?
    
    public init(onNext: (() -> Void)? = nil) {
        self.onNext = onNext
    }
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 4, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text("title_restoring_backup_intro".localized)
                    .font(.defaultLargeTitle)
                    .foregroundColor(.textPrimary)
                Text("msg_restoring_backup_intro".localized)
                    .font(Font.defaultSubtTitle)
                  .lineSpacing(1.14)
                  .foregroundColor(.textPrimary)
                Spacer()
                LoadingDotsView()
                Spacer()
            }
        })
    }
}

#Preview {
    RestoringBackupView()
}
