//
//  RestoringErrorView.swift
//  SelfUI
//
//  Created by Long Pham on 30/5/24.
//

import SwiftUI

public struct RestoringErrorView: View, BaseActions {
    var onNext: (() -> Void)?
    
    public init(onNext: (() -> Void)? = nil) {
        self.onNext = onNext
    }
    
    public var body: some View {
        BaseProgressView (totalSteps: 5, activeStep: 6, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text("title_recovery_failed".localized)
                    .modifier(Heading1TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Text("msg_recovery_failed".localized)
                    .modifier(Body1TextStyle())
                Spacer()
                ButtonView(title: "button_try_again".localized) {
                    onNext?()
                }
            }
        })
    }
}

#Preview {
    RestoringErrorView()
}
