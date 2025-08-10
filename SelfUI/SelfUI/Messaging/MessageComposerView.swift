//
//  MessageComposerView.swift
//  SelfUI
//
//  Created by Long Pham on 29/9/24.
//

import SwiftUI

public struct MessageComposerView: View {
    @State private var showAttachmentView = false
    @State private var showingImagePicker = false
    @State private var showingPhotoPicker = false
    @State private var showingDocumentPicker = false
    @State private var inputImage: UIImage?
    @State private var selectedFileName: String?
    @State private var selectedFileURLs: [URL] = []
    
    @State private var text: String = ""
    private let lineLimit = 3
    
    var onClick: (() -> Void)?
    var onText: ((String) -> Void)?
    var onImage: ((UIImage) -> Void)?
    var onSelectFile: ((URL) -> Void)?
    public init(onClick: (() -> Void)? = nil,
         onText: ((String) -> Void)? = nil,
         onImage: ((UIImage) -> Void)? = nil,
         onSelectFile: ((URL) -> Void)? = nil) {
        self.onClick = onClick
        self.onText = onText
        self.onImage = onImage
        self.onSelectFile = onSelectFile
    }
    
    public var body: some View {
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
                        self.openPhotoPicker()
                    }, label: {
                        Image("ic_camera", bundle: mainBundle)
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                    })
                    .sheet(isPresented: $showingPhotoPicker, onDismiss: {
                        print("Dismissed photo picker: \(self.inputImage)")
                        self.showAttachmentView = false
                        if let inputImage = inputImage {
                            onImage?(inputImage)
                        }
                    }) {
                        CaptureImageView { uiImage, description in
                            self.inputImage = uiImage
                        }
                    }
                    .onChange(of: self.inputImage) { newValue in
                        print("Selected image: \(self.inputImage)")
                    }
                    
                    Spacer()
                    Button(action: {
                        self.openDocumentPicker()
                    }, label: {
                        Image("ic_document", bundle: mainBundle)
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                    })
                    .onChange(of: self.selectedFileURLs, perform: { newValue in
                        print("Files change: \(newValue)")
                        self.selectedFileURLs = newValue
                        if let url = self.selectedFileURLs.first {
                            onSelectFile?(url)
                            selectedFileURLs = []
                        }
                    })
                    .sheet(isPresented: $showingDocumentPicker, onDismiss: {
                        print("Dismissed document picker: \(self.selectedFileURLs)")
                        if let url = self.selectedFileURLs.first {
                            onSelectFile?(url)
                            selectedFileURLs = []
                        }
                    }) {
                        DocumentPicker(selectedFileName: $selectedFileName, selectedFileURLs: $selectedFileURLs)
                    }
                    
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
    
    private func openPhotoPicker() {
        print("Show photo picker.")
//        showAttachmentView.toggle()
        showingPhotoPicker = true
    }
    
    private func openDocumentPicker() {
        print("Show document picker.")
//        showAttachmentView.toggle()
        showingDocumentPicker = true
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        MessageComposerView()
            .background(.red)
    }
    
}
