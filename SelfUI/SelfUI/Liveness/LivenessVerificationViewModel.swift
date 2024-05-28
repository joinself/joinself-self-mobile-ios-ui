//
//  LivenessVerificationViewModel.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import SwiftUI

class LivenessVerificationViewModel: ObservableObject {
    @Published var bodyString: AttributedString = ""
    
    init () {
        bodyString = self.calculateBodyText()
    }
    
    private func calculateBodyText() -> AttributedString {
        let text = "Liveness verification failed".localized
        let attributes = [
            ("You have 2 more verification attempts.", UIFont.systemFont(ofSize: 17), UIColor.systemPink)
        ]
        
        let attributedText = Utils.hightlightTexts(attributes: attributes, inString: text, font: UIFont.systemFont(ofSize: 17), color: .black)
        return AttributedString(attributedText)
    }
}
