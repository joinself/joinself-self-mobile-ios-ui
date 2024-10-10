//
//  MessageDTO.swift
//  SelfUI
//
//  Created by Long Pham on 4/10/24.
//

import Foundation

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
    public static let SELF_ACKNOWLEDGE = "self/acknowledge"
    public static let SELF_APPROVAL = "self/approval"
    public static let SELF_NOTIFICATION = "self/notification"
    public static let SELF_ACCOUNT_DELETION = "self/account_deletion"
    public static let SELF_CONNECTION_VERIFICATION = "self/connection_verification"
    public static let SELF_CONNECTION_UNVERIFIED = "self/connection_unverified"
    public static let SELF_FORM = "self/form"
    public static let SELF_FORM_RESPONSE = "self/form_response"
    public static let SELF_BUTTONS = "self/commands"
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

public struct MessageDTO: Identifiable, Equatable {
    public let id: String
    public let text: String
    let isMyMessage: Bool
    public let mimeType: String
    let fromType: MessageFrom
    let receiptStatus: MessageStatus
    let timestamp: String
    var status: MessageStatus = .pending // Request status
    let attachments: [AttachmentDTO]

    public init(id: String,
                text: String,
                attachments: [AttachmentDTO] = [],
                mimeType: String = MessageType.SELF_TEXT,
                fromType: MessageFrom = .sender,
                receiptStatus: MessageStatus = .pending,
                status: MessageStatus = .pending,
                timestamp: String = "") {
        self.id = id
        self.text = text
        self.attachments = attachments
        self.isMyMessage = fromType == .sender
        self.fromType = fromType
        self.receiptStatus = receiptStatus
        self.timestamp = timestamp
        self.status = status
        self.mimeType = mimeType
    }
}
