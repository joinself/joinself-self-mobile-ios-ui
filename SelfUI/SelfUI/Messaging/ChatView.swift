//
//  ChatView.swift
//  SelfUI
//
//  Created by Long Pham on 28/9/24.
//
import SwiftUI
import Combine

public struct Message: Identifiable {
    public let id: UUID
    let text: String
    let isSender: Bool
    
    public init(id: UUID, text: String, isSender: Bool) {
        self.id = id
        self.text = text
        self.isSender = isSender
    }
}

public class ChatObservableObject: ObservableObject {
    @Published var messages: [Message] = []
    public init(messages: [Message]) {
        self.messages = messages
    }
    
    public func updateMessages(newMessages: [Message]) {
        self.messages = newMessages
    }
}


public struct ChatView: View {
    @ObservedObject var chatObservableObject: ChatObservableObject
    
    @State private var newMessage: String = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @Binding var conversationName: String
    @StateObject private var keyboardResponder = KeyboardResponder()
    var onText: ((String) -> Void)?
    
    public init (conversationName: Binding<String>, chatObservableObject: ChatObservableObject, onText: ((String) -> Void)? = nil) {
        self._conversationName = conversationName
        self.onText = onText
        self.chatObservableObject = chatObservableObject
    }
    
    public var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                BaseNavigationBarView(title: conversationName, onNavigateBack: {
                    presentationMode.wrappedValue.dismiss()
                })
                if chatObservableObject.messages.isEmpty {
                    Spacer()// Empty messages
                } else {
                    List(chatObservableObject.messages) { message in
                        HStack (spacing: 8) {
                            if message.isSender {
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
                        .listRowBackground(Color.white)
                        .background(.white)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.none)
                    }
                    .scrollDismissesKeyboard(.interactively)
                    .padding()
                    .background(.white)
                    .listStyle(PlainListStyle())
                }
                
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
                MessageComposerView(onText: onText)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: keyboardResponder.currentHeight > 0 ? keyboardResponder.currentHeight : 24, trailing: 0))
            }.ignoresSafeArea()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        // Handle the image attachment here
        let message = Message(id: UUID(), text: "Image attached", isSender: true)
        //messages.append(message)
    }
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
        ChatView(conversationName: .constant("User"), chatObservableObject: ChatObservableObject(messages: [
            Message(id: UUID(), text: "Hi", isSender: true),
            Message(id: UUID(), text: "Hi", isSender: true),
            Message(id: UUID(), text: "Hello! How are you?", isSender: true),
            
            Message(id: UUID(), text: "Hi", isSender: false),
            Message(id: UUID(), text: "Hi", isSender: false),
            Message(id: UUID(), text: "Hello! How are you?", isSender: false)
        ]))
    }
    
}

