//
//  ChatView.swift
//  SelfUI
//
//  Created by Long Pham on 28/9/24.
//
import SwiftUI
import Combine

public class ChatObservableObject: ObservableObject {
    @Published var messages: [MessageDTO] = []
    public var newMessage = PassthroughSubject<MessageDTO, Never>() // handle on message changes
    public init(messages: [MessageDTO]) {
        self.messages = messages
    }
    
    public func updateMessages(newMessages: [MessageDTO]) {
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
                NavigationTitleView(title: conversationName)
                if chatObservableObject.messages.isEmpty {
                    Spacer()// Empty messages
                } else {
                    List(chatObservableObject.messages) { message in
                        MessageTextCell(messageDTO: message)
                        .listRowBackground(Color.white)
                        .background(.white)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.none)
                    }
                    .scrollDismissesKeyboard(.interactively)
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
                MessageComposerView(onText: { textMessage in
                    let newMessage = MessageDTO(id: UUID().uuidString, text: textMessage)
                    chatObservableObject.newMessage.send(newMessage)
                })
//                    .padding(EdgeInsets(top: 0, leading: 0, bottom: keyboardResponder.currentHeight > 0 ? keyboardResponder.currentHeight : 24, trailing: 0))
            }.padding()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        // Handle the image attachment here
        let message = MessageDTO(id: UUID().uuidString, text: "Image attached", fromType: .sender)
        //messages.append(message)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ChatView(conversationName: .constant("User"), chatObservableObject: ChatObservableObject(messages: [
            MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .sender),
            MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .sender),
            MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", fromType: .sender),
            
            MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .receiver),
            MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .receiver),
            MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", fromType: .receiver, timestamp: "now")
        ]))
    }
    
}

