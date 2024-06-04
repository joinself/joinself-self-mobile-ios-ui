//
//  FontLoader.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import SwiftUI
import CoreText

public class FontLoader {
    static public func loadFont() {
        if let fontUrl = Bundle(for: FontLoader.self).url(forResource: "Barlow", withExtension: "ttf"),
           let dataProvider = CGDataProvider(url: fontUrl as CFURL),
           let newFont = CGFont(dataProvider) {
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(newFont, &error) {
                print("Error loading Font!")
            } else {
                print("Loaded font")
            }
        } else {
//            assertionFailure("Error loading font")
        }
    }
}
