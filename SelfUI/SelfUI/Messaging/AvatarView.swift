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
    var displayName: String?
    private var image: UIImage?
    @Binding var icon: Image?
    
    public init(icon: Binding<Image?> = .constant(nil), imageData: Data? = nil, imageName: String = "", displayName: String? = nil, imageURL: URL? = nil) {
        self.imageData = imageData
        self.imageName = imageName
        self.displayName = displayName
        self._icon = icon
        
        print("AvatarImageURL: \(imageURL)")
        if let imageURL = imageURL {
            let image = UIImage(contentsOfFile: imageURL.path()) ?? UIImage()
            self.image = image
            print("AvatarImage: \(image)")
        }
    }
    
    public var body: some View {
        BaseAvatarView {
            if let icon = icon {
                icon
            } else if let firstLetter = displayName?.first {
                Text("\(firstLetter)")
                    .modifier(Body1TextStyle(color: .colorTextSecondary))
            }
        }
        /*ZStack {
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
        }*/
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        VStack {
            AvatarView(icon: .constant(Image("ic_self_logo", bundle: mainBundle)))
                .frame(width: Constants.AvatarSizeSmall)
            AvatarView(displayName: "User")
                .frame(width: Constants.AvatarSizeMedium)
        }
        
    }
    
}
