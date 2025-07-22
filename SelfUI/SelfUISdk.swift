//
//  SelfUISdk.swift
//  SelfUI
//
//  Created by Long Pham on 5/8/24.
//

import SwiftUI
import Combine

public class SelfUISdk: ObservableObject {
    @Published var font: Font?
    @Published var bundle: Bundle?
    @Published var customization: Bool = false
    
    public static let shared = SelfUISdk()
    let defaultLargeTitle = Font.custom("Barlow-Bold", size: 64)
    let defaultTitle = Font.custom("Barlow-Bold", size: 34)
    let defaultMessageTitle = Font.custom("Barlow-Bold", size: 21)
    let defaultBody = Font.custom("SF-Pro", size: 17)
    let defaultButton = Font.custom("Barlow-Bold", size: 17)
    let defaultBodyLarge = Font.custom("Barlow-Bold", size: 51)
    let defaultBodyMedium = Font.custom("Barlow-Medium", size: 15)
    
    private init() {
        FontLoader.loadFont(fontResourceName: "Barlow-Bold")
        FontLoader.loadFont(fontResourceName: "Barlow-Medium")
        FontLoader.loadFont(fontResourceName: "SF-Pro")
    }
    
    public func initialize(customization: Bool = false) {
        print("Customization: \(customization)")
        self.customization = customization
    }
}
