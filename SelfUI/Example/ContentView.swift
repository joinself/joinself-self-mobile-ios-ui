//
//  ContentView.swift
//  Example
//
//  Created by Long Pham on 14/5/24.
//

import SwiftUI
import SelfUI
import Combine

class MyViewModel: ObservableObject {
    @Published var chatObservableObject: ChatObservableObject = ChatObservableObject(messages: [
        MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", mimeType: MessageType.SELF_DOCUMENT_SIGN, fromType: .receiver, timestamp: "now"),
        
        MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .sender),
        MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .sender),
        MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", fromType: .sender),
        
        MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .receiver),
        MessageDTO(id: UUID().uuidString, text: "Hi", fromType: .receiver),
        MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", fromType: .receiver, timestamp: "now"),
        MessageDTO(id: UUID().uuidString, text: "Hello! How are you?", mimeType: MessageType.SELF_CREDENTIAL_REQUEST, fromType: .receiver, timestamp: "now")
    ])
}

struct ContentView: View {
    
    @ObservedObject var viewModel = MyViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    CaptureDocumentView(captureMode: .detectIDCardMRZ)
                } label: {
                    Text("Document Capture")
                }
                
                NavigationLink {
                    VerifyDocumentFlow { image1, image2 in
                        print("Verify image: \(image1), \(image2)")
                    }
                } label: {
                    Text("Verify Document")
                }
                
                NavigationLink {
                    ZStack {
                        Color.black.ignoresSafeArea()
                        
                        ParentChildView(items: [DocumentItem(title: "Passport",isParent: true, iconName: "VN", children: [DocumentItem(title: "Given Names",
                                                                                                                                       isParent: false),
                                                                                                                          DocumentItem(title: "Nationality",
                                                                                                                                       isParent: false)]),
                                                DocumentItem(title: "National Identity",
                                                             isParent: true,
                                                             children: [
                                                                DocumentItem(title: "Given Names",
                                                                             isParent: false,
                                                                             children:[DocumentItem(title: "Next Task", isParent: false)]),
                                                                DocumentItem(title: "Nationality",
                                                                             isParent: true,
                                                                             children: [DocumentItem(title: "Expiry data", isParent: false)])])])
                        .background(.white)
                        .scrollContentBackground(.hidden)
                    }
                } label: {
                    Text("Display Document")
                }
                
                NavigationLink {
                    ChatView(conversationName: .constant("User"), chatObservableObject: viewModel.chatObservableObject)
                        .onReceive(viewModel.chatObservableObject.newMessage, perform: { newMessage in
                            print("New message DTO.....: \(newMessage)")
                            viewModel.chatObservableObject.updateMessages(newMessages: [newMessage])
                        })
                } label: {
                    Text("Chat View")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
