//
//  ParentItemView.swift
//  SelfUI
//
//  Created by Long Pham on 15/11/24.
//

import SwiftUI

public struct ParentItemView: View {
    let title: String
    let imageName: String
    public init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
    
    public var body: some View {
        HStack {
            Image(imageName, bundle: mainBundle)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 32, height: 32)
                
            Text(title)
                .font(.headline)
            Spacer()
        }
    }
}

#Preview {
    ParentItemView(title: "Passport", imageName: "GB")
}
