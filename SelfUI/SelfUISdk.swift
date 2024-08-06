//
//  SelfUISdk.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI

public class SelfUISdk: ObservableObject {
    @Published var font: Font?
    @Published var bundle: Bundle?
    @Published var customization: Bool = false
    
    public static let shared = SelfUISdk()
    
    private init() {
        FontLoader.loadFont()
    }
    
    public func initialize(customization: Bool = false) {
        print("Customization: \(customization)")
        self.customization = customization
    }
}
