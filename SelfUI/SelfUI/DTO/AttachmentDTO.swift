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
    public let formattedSize: String
    public let isPlayable: Bool
    
    public init(name: String, mime: String, localPath: String, size: Int64, formattedSize: String = "", isPlayable: Bool = false) {
        self.name = name
        self.mime = mime
        self.localPath = localPath
        self.size = size
        self.formattedSize = formattedSize
        self.isPlayable = isPlayable
    }
}

extension Int64 {
    var formattedFileSize: String? {
        print("formattedFileSize: \(self)")
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useMB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: self)
    }
}
