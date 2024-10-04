//
//  UserDetailView.swift
//  SelfUI
//
//  Created by Long Pham on 4/10/24.
//

import SwiftUI

public struct UserDetailView: View {
    @State private var showingImagePicker = false
    @Binding private var inputImage: UIImage?
    
    let name: String
    let details: String
    private var onFinish: (() -> Void)?
    public init(uiImage: Binding<UIImage?> = .constant(nil), name: String = "Name", details: String = "Description", onFinish: (() -> Void)? = nil) {
        self._inputImage = uiImage
        self.name = name
        self.details = details
        self.onFinish = onFinish
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
              .foregroundColor(.clear)
              .frame(maxWidth: .infinity, maxHeight: 138, alignment: .center)
              .background(.white.opacity(0))
              .cornerRadius(8)
              .overlay(
                RoundedRectangle(cornerRadius: 8)
                  .inset(by: 1)
                  .stroke(Color(red: 0, green: 0.78, blue: 0.53), lineWidth: 2)
              )
            
            
            HStack(alignment: .center, spacing: 12) {
                if inputImage != nil {
                    Image(uiImage: inputImage!)
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .foregroundColor(.defaultBlue)
                      .clipShape(Circle())
                      .frame(width: Constants.AvatarWidth, height: Constants.AvatarWidth)
                } else {
                    Image(systemName: "person.crop.rectangle.fill")
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .foregroundColor(.defaultBlue)
                      .clipShape(Circle())
                      .frame(width: Constants.AvatarWidth, height: Constants.AvatarWidth)
                }
                VStack (alignment: .leading) {
                    // Heading/H3
                    Text(name)
                      .font(
                        Font.defaultTitle
                      )
                      .foregroundColor(.textPrimary)
                    Text(details)
                        .foregroundStyle(Color.defaultGreen)
                }
                Spacer()
                Button {
                    // show editing
                    showingImagePicker = true
                    
                } label: {
                    Image("ic_chevron_right", bundle: mainBundle)
                        .frame(width: 44, height: 44)
                        .foregroundColor(.black)
                }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage)
                }

                
            }
            .backgroundStyle(.white)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 138)
        }
    }
    
    private func loadImage() {
        print("Image picker is dismissed.")
        self.onFinish?()
    }
}

#Preview {
    UserDetailView()
}

