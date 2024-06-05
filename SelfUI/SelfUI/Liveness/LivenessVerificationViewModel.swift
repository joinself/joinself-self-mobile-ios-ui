//
//  LivenessVerificationViewModel.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import SwiftUI

class LivenessVerificationViewModel: ObservableObject {
    @Published var bodyString: AttributedString = ""
    @Published var remainingRetryNumber: Int = 0
    
    init () {
        bodyString = self.calculateBodyText()
    }
    
    func update () {
        bodyString = self.calculateBodyText()
    }
    
    private func calculateBodyText() -> AttributedString {
        let text = String(format: "Liveness verification failed".localized, remainingRetryNumber)
        let attributes = [
            ("You have \(remainingRetryNumber) more verification attempts.", UIFont.systemFont(ofSize: 17), UIColor.systemPink)
        ]
        
        let attributedText = Utils.hightlightTexts(attributes: attributes, inString: text, font: UIFont.systemFont(ofSize: 17), color: .black)
        return AttributedString(attributedText)
    }
}
