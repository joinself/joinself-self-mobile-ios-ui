//
//  ChatView.swift
//  SelfUI
//
//  Created by Long Pham on 28/9/24.
//
import SwiftUI

public struct ChatView: View {
    @State private var messages: [Message] = []
    @State private var newMessage: String = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    public init () {
        
    }
    
    public var body: some View {
        VStack {
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
            }
            .listStyle(PlainListStyle())
            
            HStack {
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
            .padding()
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
    ChatView()
}

