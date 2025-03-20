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
                    .modifier(Heading1TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Text("msg_restoring_backup_intro".localized)
                    .modifier(Heading4TextStyle())
                Spacer()
                LoadingDotsView()
                Spacer()
            }
            .onAppear {
                onNext?()
            }
        })
    }
}

#Preview {
    RestoringBackupView()
}
