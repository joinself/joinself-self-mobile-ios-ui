//
//  EmailFlowViewModel.swift
//  SelfUI
//
//  Created by Long Pham on 30/7/24.
//

import SwiftUI
import Combine

public class EmailFlowViewModel: ObservableObject {
    @Published public var isVerified: Bool = false
    @Published public var emailAddress: String = ""
    public init(isVerified: Bool) {
        self.isVerified = isVerified
    }
}
