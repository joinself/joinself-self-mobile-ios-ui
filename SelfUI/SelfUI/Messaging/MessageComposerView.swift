//
//  MessageComposerView.swift
//  SelfUI
//
//  Created by Long Pham on 29/9/24.
//

import SwiftUI

struct MessageComposerView: View {
    @State private var showAttachmentView = false
    @State private var text: String = ""
    
    var onClick: (() -> Void)?
    init(onClick: (() -> Void)? = nil) {
        self.onClick = onClick
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Type a message", text: $text)
                    .padding(.leading, 30) // Add padding to make space for the icon
                    .overlay(
                        HStack {
                            Button(action: {
                                print("Show attachemnts.")
                                showAttachmentView.toggle()
                            }, label: {
                                Image(systemName: "paperclip")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 8)
                            })
                            Spacer()
                        }
                    )
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding()
                
                if !text.isEmpty {
                    Button(action: {
                        // TODO: Send button clicked
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
                        print("Show attachemnts.")
                        showAttachmentView.toggle()
                    }, label: {
                        Image("ic_gallary", bundle: mainBundle)
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                    })
                }
                .transition(.opacity)
                .padding()
            }
        }
    }
}

#Preview {
    MessageComposerView()
}
