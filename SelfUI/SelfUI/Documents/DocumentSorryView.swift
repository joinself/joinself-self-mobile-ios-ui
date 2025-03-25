//
//  DocumentSorryView.swift
//  SelfUI
//
//  Created by Long Pham on 29/5/24.
//

import SwiftUI

public struct DocumentSorryView: View {
    
    public init(onButtonClicked: @escaping () -> Void, onNavigateBack: @escaping () -> Void) {
        self.onButtonClicked = onButtonClicked
        self.onNavigateBack = onNavigateBack
    }
    
    var onButtonClicked: () -> Void
    var onNavigateBack: () -> Void
    
    public var body: some View {
        
        BaseProgressView (totalSteps: 5, activeStep: 5, content: {
            VStack(alignment: .leading, spacing: 30) {
                Text("msg_document_failed".localized)
                    .modifier(Heading3TextStyle())
                    .padding(.top, Constants.Heading1PaddingTop)
                Spacer()
            }
            
            Spacer()
            ButtonView(title: "Continue".localized) {
                onButtonClicked()
            }
        })
    }
}

#Preview {
    DocumentSorryView(onButtonClicked: {
        
    }, onNavigateBack: {
        
    })
}

