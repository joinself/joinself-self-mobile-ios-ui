//
//  AttachmentDTO.swift
//  SelfUI
//
//  Created by Long Pham on 10/10/24.
//

import Foundation

public struct AttachmentDTO: Equatable {
    public let name: String
    public let mime: String
    public let localPath: String
    public let size: Int64 // in bytes
    
    public init(name: String, mime: String, localPath: String, size: Int64) {
        self.name = name
        self.mime = mime
        self.localPath = localPath
        self.size = size
    }
}

extension Int64 {
    var formattedFileSize: String? {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useMB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: self)
    }
}
