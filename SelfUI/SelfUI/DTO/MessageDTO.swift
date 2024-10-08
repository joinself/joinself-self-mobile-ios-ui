//
//  MessageDTO.swift
//  SelfUI
//
//  Created by Long Pham on 4/10/24.
//

import Foundation

public struct MessageType {
    static let SELF_TEXT = "self/text"
    static let SELF_CALL = "self/call"
    static let SELF_IMAGE = "self/image"
    static let SELF_VIDEO = "self/video"
    static let SELF_AUDIO = "self/audio"
    static let SELF_LINK = "self/link"
    static let SELF_FILE = "self/file"
    static let SELF_CONNECTION = "self/connection"
    
    static let GROUP_JOIN = "self/group_join"
    static let GROUP_LEAVE = "self/group_leave"
    static let SELF_CREDENTIAL_REQUEST = "self/credential_request"
    static let SELF_CREDENTIAL = "self/credential"
    static let SELF_DOCUMENT_SIGN = "self/document_sign"
    static let SELF_ACKNOWLEDGE = "self/acknowledge"
    static let SELF_APPROVAL = "self/approval"
    static let SELF_NOTIFICATION = "self/notification"
    static let SELF_ACCOUNT_DELETION = "self/account_deletion"
    static let SELF_CONNECTION_VERIFICATION = "self/connection_verification"
    static let SELF_CONNECTION_UNVERIFIED = "self/connection_unverified"
    static let SELF_FORM = "self/form"
    static let SELF_FORM_RESPONSE = "self/form_response"
    static let SELF_BUTTONS = "self/commands"
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

public struct MessageDTO: Identifiable {
    public let id: String
    public let text: String
    let isSender: Bool
    public let mimeType: String = MessageType.SELF_TEXT
    let fromType: MessageFrom
    let receiptStatus: MessageStatus
    let timestamp: String

    public init(id: String,
                text: String,
                fromType: MessageFrom = .sender,
                receiptStatus: MessageStatus = .pending,
                timestamp: String = "") {
        self.id = id
        self.text = text
        self.isSender = fromType == .sender
        self.fromType = fromType
        self.receiptStatus = receiptStatus
        self.timestamp = timestamp
    }
}
