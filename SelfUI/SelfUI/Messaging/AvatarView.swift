//
//  AvatarView.swift
//  SelfUI
//
//  Created by Long Pham on 27/9/24.
//

import SwiftUI

public struct AvatarView: View {
    var imageData: Data? = nil
    var imageURL: URL? = nil
    var imageName: String
    var userName: String
    private var image: UIImage?
    private var avatarSize: CGFloat
    
    public init(imageData: Data? = nil, imageName: String = "", userName: String = "", imageURL: URL? = nil, avatarSize: CGFloat = 48) {
        self.imageData = imageData
        self.imageName = imageName
        self.userName = userName
        self.avatarSize = avatarSize
        
        print("AvatarImageURL: \(imageURL)")
        if let imageURL = imageURL {
            let image = UIImage(contentsOfFile: imageURL.path()) ?? UIImage()
            self.image = image
            print("AvatarImage: \(image)")
        }
    }
    
    public var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: avatarSize, height: avatarSize)
                    .background(Color.defaultPink)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
            }
            else if let imageData = imageData, let uiImage = UIImage(data: imageData) {
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
            
            if !userName.isEmpty, image == nil{
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
            AvatarView(imageName: "", userName: "ACME", imageURL: mainBundle?.url(forResource: "Image", withExtension: "jpeg"), avatarSize: 200)
        }
        
    }
    
}
