//
//  CredentialDTO.swift
//  SelfUI
//
//  Created by Long Pham on 11/10/24.
//

import Foundation

public struct CredentialDTO: Hashable, Equatable {
    public let subject: String
    public let value: String
    let signer: String
    
    public init(subject: String, value: String, signer: String) {
        self.subject = subject
        self.value = value
        self.signer = signer
    }
}
