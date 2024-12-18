//
//  RestoreIntroView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct RestoreIntroView: View, BaseActions {
    var onNext: (() -> Void)?
    
    public init(onNext: (() -> Void)? = nil) {
        self.onNext = onNext
    }
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 1, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text("title_restore_intro".localized)
                    .font(.defaultTitle)
                    .foregroundColor(.textPrimary)
                Text("msg_restore_intro".localized)
                    .font(Font.defaultBody)
                  .lineSpacing(1.14)
                  .foregroundColor(.black)
                Spacer()
                
                OutlinedButton(title: "button_continue".localized, outlineColor: .defaultPink) {
                    onNext?()
                }
            }
        })
    }
}

#Preview {
    RestoreIntroView()
}
