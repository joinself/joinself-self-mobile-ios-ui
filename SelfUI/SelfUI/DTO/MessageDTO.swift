//
//  MessageDTO.swift
//  SelfUI
//
//  Created by Long Pham on 4/10/24.
//

import Foundation

public struct MessageType {
    static let SELF_TEXT = "self/text"
    static let SELF_IMAGE = "self/image"
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
