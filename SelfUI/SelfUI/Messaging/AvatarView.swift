//
//  AvatarView.swift
//  SelfUI
//
//  Created by Long Pham on 27/9/24.
//

import SwiftUI

public struct AvatarView: View {
    var imageData: Data? = nil
    var imageName: String
    var userName: String
    public init(imageData: Data? = nil, imageName: String = "", userName: String = "") {
        self.imageData = imageData
        self.imageName = imageName
        self.userName = userName
    }
    
    public var body: some View {
        ZStack {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            } else {
                Image(imageName)
                    .resizable()
    //                .aspectRatio(contentMode: .fill)
    //                .frame(width: 100, height: 100)
                    .background(Color.defaultPink)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
            }
            
            if !userName.isEmpty {
                Text(userName.substring(0, to: 0))
                    .font(.headline)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            }   
        }
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        VStack {
            AvatarView(imageName: "", userName: "")
            AvatarView(imageName: "", userName: "ACME")
        }
        
    }
    
}
