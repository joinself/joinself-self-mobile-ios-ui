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
    
    public func updateMessageAt(message: MessageDTO, at: Int) {
        print("UPDATE MESSAGE at index: \(at) receiptStatus: \(message.receiptStatus)")
        if at >= messages.count || at < 0 {
            print("Invalid message at: \(at)")
            return
        }
        self.messages[at].receiptStatus = message.receiptStatus
    }
}


public struct ChatView: View {
    @ObservedObject var chatObservableObject: ChatObservableObject
    
    @State private var newMessage: String = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var replyToMessage: MessageDTO?
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var conversationName: String
    @StateObject private var keyboardResponder = KeyboardResponder()
    private var actionAccept: ((MessageDTO) -> Void)?
    private var actionReject: ((MessageDTO) -> Void)?
    private var actionRead: ((MessageDTO) -> Void)?
    
    let imageURL: URL?
    private let bottomSpaceID = 123456
    public init (conversationName: Binding<String>, imageURL: URL? = nil,
                 chatObservableObject: ChatObservableObject,
                 actionAccept: ((MessageDTO) -> Void)? = nil,
                 actionReject: ((MessageDTO) -> Void)? = nil,
                 actionRead: ((MessageDTO) -> Void)? = nil) {
        self._conversationName = conversationName
        self.chatObservableObject = chatObservableObject
        self.actionAccept = actionAccept
        self.actionReject = actionReject
        self.actionRead = actionRead
        self.imageURL = imageURL
    }
    
    public var body: some View {
        VStack {
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
                            .onAppear {
                                actionRead?(message)
                            }
                        
                        case MessageType.SELF_DOCUMENT_SIGN:
                            DocumentSignCell(messageDTO: message) {
                                actionAccept?(message)
                            } actionReject: {
                                actionReject?(message)
                            }
                            .onAppear {
                                actionRead?(message)
                            }
                            
                        case MessageType.SELF_SIGNING_REQUEST:
                            
                            SigningRequestCell(messageDTO: message) {
                                actionAccept?(message)
                            } actionReject: {
                                actionReject?(message)
                            }
                            .onAppear {
                                actionRead?(message)
                            }
                            
                        case MessageType.SELF_IMAGE:
                            MessageImageCell(messageDTO: message)
                                .onAppear {
                                    actionRead?(message)
                                }
                        
                        case MessageType.SELF_VIDEO:
                            MessageVideoCell(messageDTO: message)
                                .onAppear {
                                    actionRead?(message)
                                }
                            
                        case MessageType.SELF_FILE:
                            FileCell(messageDTO: message)
                                .onAppear {
                                    actionRead?(message)
                                }
                            
                        default:
                            MessageTextCell(messageDTO: message)
                                .onAppear {
                                    actionRead?(message)
                                }
                                .modifier(DraggableModifier(direction: .horizontal, draggedOffset: .zero, onSwipe: { direction in
                                    if direction == .right {
                                        self.replyToMessage = message
                                    }
                                }))
                        }
                        if message == chatObservableObject.messages.last {
                            Spacer()
                                .listRowBackground(Color.white)
                                .listRowSeparator(.hidden)
                                .id(bottomSpaceID)
                        }
                    }
                    .onAppear {
                        self.scrollToBottom(scrollViewProxy: scrollViewProxy)
                    }
                    
                    .scrollDismissesKeyboard(.interactively)
                    .background(.white)
                    .listStyle(PlainListStyle())
                    .onChange(of: chatObservableObject.messages) { _ in
                        self.scrollToBottom(scrollViewProxy: scrollViewProxy)
                    }
                    .onChange(of: keyboardResponder.currentHeight) { newValue in
                        self.scrollToBottom(scrollViewProxy: scrollViewProxy)
                    }
                }
            }
            if let replyTo = replyToMessage {
                HStack {
                    Text(LocalizedStringKey(replyTo.text))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 2)
                    Spacer()
                    Button {
                        replyToMessage = nil
                    } label: {
                        Image(systemName: "x.circle")
                    }

                }
            }
            MessageComposerView(onText: { textMessage in
                let newMessage = MessageDTO(id: UUID().uuidString, text: textMessage)
                newMessage.reference = replyToMessage
                chatObservableObject.newMessage.send(newMessage)
                replyToMessage = nil
            }) { inputImage in
                let newMessage = MessageDTO(id: UUID().uuidString, text: "", image: inputImage, mimeType: MessageType.SELF_IMAGE)
                chatObservableObject.newMessage.send(newMessage)
            } onSelectFile: { url in
                let newMessage = MessageDTO(id: UUID().uuidString, text: "", fileURLs: [url], mimeType: MessageType.SELF_FILE)
                chatObservableObject.newMessage.send(newMessage)
            }
        }
        .background(Color.backgroundPrimary)
    }
    
    private func scrollToBottom(scrollViewProxy: ScrollViewProxy) {
        withAnimation {
            scrollViewProxy.scrollTo(bottomSpaceID, anchor: .bottom)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ChatView(conversationName: .constant("User"), imageURL: mainBundle?.url(forResource: "Image", withExtension: "jpeg"), chatObservableObject: ChatObservableObject(messages: [
            MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", mimeType: MessageType.SELF_DOCUMENT_SIGN, fromType: .receiver, timestamp: "now"),
            
            MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .sender, reference: MessageDTO(id: UUID().uuidString, text: "Reference Messsage", fromType: .receiver)),
            MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .sender),
            MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", fromType: .sender),
            
            MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .receiver),
            MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .receiver),
            MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", fromType: .receiver, timestamp: "now"),
            MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", mimeType: MessageType.SELF_CREDENTIAL_REQUEST, fromType: .receiver, timestamp: "now"),
            MessageDTO(id: UUID().uuidString, text: "Signing Request Message", mimeType: MessageType.SELF_SIGNING_REQUEST, fromType: .receiver, timestamp: "now"),
            MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", mimeType: MessageType.SELF_FILE, fromType: .receiver, timestamp: "now")
        ]))
    }
    
}

