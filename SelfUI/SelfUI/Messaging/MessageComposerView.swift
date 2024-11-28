//
//  MessageComposerView.swift
//  SelfUI
//
//  Created by Long Pham on 29/9/24.
//

import SwiftUI

struct MessageComposerView: View {
    @State private var showAttachmentView = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var text: String = ""
    private let lineLimit = 3
    
    var onClick: (() -> Void)?
    var onText: ((String) -> Void)?
    var onImage: ((UIImage) -> Void)?
    init(onClick: (() -> Void)? = nil,
         onText: ((String) -> Void)? = nil,
         onImage: ((UIImage) -> Void)? = nil) {
        self.onClick = onClick
        self.onText = onText
        self.onImage = onImage
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("", text: $text, prompt: Text("Type a message").foregroundColor(.defaultDark), axis: .vertical)
                    .lineLimit(1...5)
                    .font(.defaultBody)
                    .tint(.defaultDark)
                    .foregroundColor(.textPrimary)
                    .padding(.leading, 36) // Add padding to make space for the icon
                    .overlay(
                        HStack {
                            Button(action: {
                                print("Show attachemnts.")
                                showAttachmentView.toggle()
                            }, label: {
                                Image("ic_paperclip", bundle: mainBundle)
                                    .foregroundColor(.gray)
                                    .padding(.leading, 8)
                            })
                            Spacer()
                        }
                    )
                    .padding(8)
                    .background(Color.defaultGrayBackground)
                    .cornerRadius(8)
                    .padding()
                
                if !text.isEmpty {
                    Button(action: {
                        onText?(text)
                        text = ""
                    }) {
                        Image(systemName: "paperplane")
                    }
                    .transition(.opacity)
                    .padding()
                    Spacer()
                }
                
            }
            
            if showAttachmentView {
                // Bottom Attachment View
                HStack {
                    Button(action: {
                        print("Show attachemnts.")
                        showAttachmentView.toggle()
                    }, label: {
                        Image("ic_camera", bundle: mainBundle)
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                    })
                    Spacer()
                    Button(action: {
                        print("Show attachemnts.")
                        showAttachmentView.toggle()
                    }, label: {
                        Image("ic_document", bundle: mainBundle)
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                    })
                    
                    Spacer()
                    Button(action: {
                        print("Show gallery.")
                        self.openGallery()
                    }, label: {
                        Image(ResourceContants.ICON_GALLERY, bundle: mainBundle)
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                    })
                    .sheet(isPresented: $showingImagePicker, onDismiss: {
                        print("Dismissed gallery: \(self.inputImage)")
                        self.showAttachmentView = false
                        if let inputImage = inputImage {
                            onImage?(inputImage)
                        }
                    }) {
                        ImagePicker(image: $inputImage)
                    }
                }
                .transition(.opacity)
                .padding()
            }
        }
    }
    
    private func openGallery() {
//        showAttachmentView.toggle()
        showingImagePicker = true
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        MessageComposerView()
            .background(.red)
    }
    
}
