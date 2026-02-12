//
//  MessageDTO.swift
//  SelfUI
//
//  Created by Long Pham on 4/10/24.
//

import Foundation
import SwiftUI
import Combine

public struct MessageType {
    public static let SELF_TEXT = "self/text"
    public static let SELF_CALL = "self/call"
    public static let SELF_IMAGE = "self/image"
    public static let SELF_VIDEO = "self/video"
    public static let SELF_AUDIO = "self/audio"
    public static let SELF_LINK = "self/link"
    public static let SELF_FILE = "self/file"
    public static let SELF_CONNECTION = "self/connection"
    
    public static let GROUP_JOIN = "self/group_join"
    public static let GROUP_LEAVE = "self/group_leave"
    public static let SELF_CREDENTIAL_REQUEST = "self/credential_request"
    public static let SELF_CREDENTIAL = "self/credential"
    public static let SELF_DOCUMENT_SIGN = "self/document_sign"
    public static let SELF_CUSTOM = "self/custom"
    public static let SELF_ACKNOWLEDGE = "self/acknowledge"
    public static let SELF_APPROVAL = "self/approval"
    public static let SELF_NOTIFICATION = "self/notification"
    public static let SELF_ACCOUNT_DELETION = "self/account_deletion"
    public static let SELF_CONNECTION_VERIFICATION = "self/connection_verification"
    public static let SELF_CONNECTION_UNVERIFIED = "self/connection_unverified"
    public static let SELF_FORM = "self/form"
    public static let SELF_FORM_RESPONSE = "self/form_response"
    public static let SELF_BUTTONS = "self/commands"
    public static let SELF_SIGNING_REQUEST = "self/signing_request"
}

public enum MessageFrom: String, CaseIterable {
    case sender, receiver, system
}

public enum MessageStatus: String, CaseIterable {
    case none
    case pending
    case sent
    case delivered
    case read
    case accepted
    case rejected
    case verified
    case error
}

public enum MessagePosition: CaseIterable, Equatable {
    case center
    case left
    case right
}

public class MessageDTO: ObservableObject, Identifiable, Equatable {
    public let id: String
    public let toAddress: String
    public let fromAddress: String
    public let messageId: String
    public let text: String
    public var image: UIImage? //FIXME: should use fileURL
    public var fileURLs: [URL] = []
    let isMyMessage: Bool
    
    public var messagePosition: MessagePosition = .center
    public let mimeType: String
    let fromType: MessageFrom
    @Published public var receiptStatus: MessageStatus
    let timestamp: String
    @Published public var status: MessageStatus = .pending // Request status
    public let attachments: [AttachmentDTO]
    let credential: CredentialDTO?
    public var reference: MessageDTO?
    public let selfieRequired: Bool
    
    // Equatable conformance
    public static func == (lhs: MessageDTO, rhs: MessageDTO) -> Bool {
        return lhs.id == rhs.id // && lhs.name == rhs.name && lhs.description == rhs.description
    }

    public init(id: String,
                messageId: String = "",
                toAddress: String = "",
                fromAddress: String = "",
                text: String,
                image: UIImage? = nil,
                fileURLs: [URL] = [],
                attachments: [AttachmentDTO] = [],
                credential: CredentialDTO? = nil,
                mimeType: String = MessageType.SELF_TEXT,
                fromType: MessageFrom = .sender,
                receiptStatus: MessageStatus = .pending,
                status: MessageStatus = .pending,
                timestamp: String = "", reference: MessageDTO? = nil, position: MessagePosition = .center, selfieRequired: Bool = false) {
        self.id = id
        self.messageId = messageId
        self.text = text
        self.image = image
        self.fileURLs = fileURLs
        self.attachments = attachments
        self.credential = credential
        self.isMyMessage = fromType == .sender
        self.fromType = fromType
        self.receiptStatus = receiptStatus
        self.timestamp = timestamp
        self.status = status
        self.mimeType = mimeType
        self.reference = reference
        self.selfieRequired = selfieRequired
        self.toAddress = toAddress
        self.fromAddress = fromAddress
        self.messagePosition = position
    }
    
    func displayFileSize() -> String {
        var displaySize: String?
        
        if let size = attachments.first?.size.formattedFileSize {
            displaySize = "\(size)"
        } else {
            displaySize = attachments.first?.formattedSize ?? "0 MB"
        }
        
        return displaySize ?? "0 MB"
    }
}

public enum ConnectionType: String, CaseIterable {
    case selfApp
    case organizationApp
    case individual
}


public class ChatHistory: ObservableObject, Identifiable, Equatable {
    public let id: String
    let title: String
    let subtitle: String
    @Published public var badge: String
    let timestamp: String
    let connectionType: ConnectionType
    let appName: String?
    let icon: Image?
    let imageURL: URL?
    public init(id: String,
                title: String,
                subtitle: String,
                timestamp: String = "",
                badge: String,
                icon: Image? = nil,
                imageURL: URL? = nil,
                appName: String? = nil,
                connectionType: ConnectionType = .selfApp) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.badge = badge
        self.timestamp = timestamp
        self.icon = icon
        self.imageURL = imageURL
        self.appName = appName
        self.connectionType = connectionType
    }
    
    public static func == (lhs: ChatHistory, rhs: ChatHistory) -> Bool {
        return lhs.id == rhs.id
    }
}
