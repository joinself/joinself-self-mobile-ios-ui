//
//  MessageComposeView.swift
//  SelfUI
//
//  Created by Long Pham on 31/7/24.
//

import SwiftUI
import MessageUI

struct MessageComposeView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var recipients: [String]?
    var body: String?
    var dismissed: (() -> Void)?
    @Binding var result: MessageComposeResult?
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        var parent: MessageComposeView
        
        init(parent: MessageComposeView) {
            self.parent = parent
        }
        
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            print("Result: \(result)")
            parent.result = result
            controller.dismiss(animated: true) {
                self.parent.presentationMode.wrappedValue.dismiss()
                self.parent.dismissed?()
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let vc = MFMessageComposeViewController()
        vc.messageComposeDelegate = context.coordinator
        vc.recipients = recipients
        vc.body = body
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}
}
