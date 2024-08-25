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
    let defaultLargeTitle = Font.custom("Barlow", size: 64)
    let defaultTitle = Font.custom("Barlow-Bold", size: 36)
    let defaultBody = Font.custom("SF-Pro", size: 17)
    
    private init() {
        FontLoader.loadFont(fontResourceName: "Barlow-Bold")
        FontLoader.loadFont(fontResourceName: "SF-Pro")
    }
    
    public func initialize(customization: Bool = false) {
        print("Customization: \(customization)")
        self.customization = customization
    }
}
