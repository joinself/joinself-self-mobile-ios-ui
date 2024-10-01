//
//  ChatView.swift
//  SelfUI
//
//  Created by Long Pham on 28/9/24.
//
import SwiftUI

public struct ChatView: View {
    @State private var messages: [Message] = [
        Message(id: UUID(), text: "Hello", isUser: true),
        Message(id: UUID(), text: "Hello", isUser: false)
    ]
    @State private var newMessage: String = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @Binding var conversationName: String
    public init (conversationName: Binding<String>) {
        self._conversationName = conversationName
        
        print("ChatView: \(conversationName)")
    }
    
    public var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                BaseNavigationBarView(title: conversationName, onNavigateBack: {
                    presentationMode.wrappedValue.dismiss()
                })
                List(messages) { message in
                    HStack {
                        if message.isUser {
                            Spacer()
                            Text(message.text)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        } else {
                            Text(message.text)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                            Spacer()
                        }
                    }
                    .background(.white)
                    .listRowInsets(EdgeInsets())
                }
                .scrollDismissesKeyboard(.interactively)
                .padding()
                .background(.white)
                .listStyle(PlainListStyle())
                
                /*HStack {
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Image(systemName: "photo")
                            .font(.system(size: 24))
                    }
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: $inputImage)
                    }
                    
                    TextField("Type a message", text: $newMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: sendMessage) {
                        Text("Send")
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
                .padding()*/
                MessageComposerView()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
            }.ignoresSafeArea()
        }
    }
    
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        let message = Message(id: UUID(), text: newMessage, isUser: true)
        messages.append(message)
        newMessage = ""
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        // Handle the image attachment here
        let message = Message(id: UUID(), text: "Image attached", isUser: true)
        messages.append(message)
    }
}

struct Message: Identifiable {
    let id: UUID
    let text: String
    let isUser: Bool
}

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ChatView(conversationName: .constant("User"))
    }
    
}

