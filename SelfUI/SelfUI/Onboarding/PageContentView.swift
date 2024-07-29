//
//  PageContentView.swift
//  SelfUI
//
//  Created by Long Pham on 14/5/24.
//

import SwiftUI

public struct PageContentView: View {
    
    private let title: String
    private let description: String
    
    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            // Heading/H3
            Text(title)
              .font(
                Font.custom("Barlow", size: 36)
                  .weight(.bold)
              )
              .foregroundColor(.black)
              .frame(maxWidth: .infinity, alignment: .bottomLeading)
            // Paragraph/Body Primary
            Text(description)
              .font(Font.custom("SF Pro", size: 17))
              .foregroundColor(.black)
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(.horizontal, 15)
        .padding(.top, 100)
        .padding(.bottom, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    PageContentView(title: "secure_communication_title".localized, description: "secure_communication_description".localized)
}
