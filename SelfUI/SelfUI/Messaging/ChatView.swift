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
    private var actionAccept: ((MessageDTO) -> Void)?
    private var actionReject: ((MessageDTO) -> Void)?
    private var actionRead: ((MessageDTO) -> Void)?
    
    public init (conversationName: Binding<String>,
                 chatObservableObject: ChatObservableObject,
                 actionAccept: ((MessageDTO) -> Void)? = nil,
                 actionReject: ((MessageDTO) -> Void)? = nil,
                 actionRead: ((MessageDTO) -> Void)? = nil) {
        self._conversationName = conversationName
        self.chatObservableObject = chatObservableObject
        self.actionAccept = actionAccept
        self.actionReject = actionReject
        self.actionRead = actionRead
    }
    
    public var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                NavigationTitleView(title: conversationName)
                if chatObservableObject.messages.isEmpty {
                    Spacer()// Empty messages
                } else {
                    ScrollViewReader { scrollViewProxy in
                        List(chatObservableObject.messages) { message in
                            switch message.mimeType {
                            case MessageType.SELF_CREDENTIAL_REQUEST:
                                CredentialRequestCell(messageDTO: message) {
                                    actionAccept?(message)
                                } actionReject: {
                                    actionReject?(message)
                                }
                            
                            case MessageType.SELF_DOCUMENT_SIGN:
                                DocumentSignCell(messageDTO: message) {
                                    actionAccept?(message)
                                } actionReject: {
                                    actionReject?(message)
                                }
                                
                            default:
                                MessageTextCell(messageDTO: message)
                                    .onAppear {
                                        actionRead?(message)
                                    }
                            }
                        }
                        
                        .scrollDismissesKeyboard(.interactively)
                        .background(.white)
                        .listStyle(PlainListStyle())
                        .onChange(of: chatObservableObject.messages) { _ in
                            withAnimation {
                                scrollViewProxy.scrollTo(chatObservableObject.messages.last?.id, anchor: .bottom)
                            }
                        }
                    }
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
            MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", mimeType: MessageType.SELF_DOCUMENT_SIGN, fromType: .receiver, timestamp: "now"),
            
            MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .sender),
            MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .sender),
            MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", fromType: .sender),
            
            MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .receiver),
            MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .receiver),
            MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", fromType: .receiver, timestamp: "now"),
            MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", mimeType: MessageType.SELF_CREDENTIAL_REQUEST, fromType: .receiver, timestamp: "now")
        ]))
    }
    
}

