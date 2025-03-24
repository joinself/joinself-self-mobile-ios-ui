//
//  FontLoader.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import SwiftUI
import CoreText

public class FontLoader {
    static public func loadFont(fontResourceName: String) {
        if let fontUrl = Bundle(for: FontLoader.self).url(forResource: fontResourceName, withExtension: "ttf"),
           let dataProvider = CGDataProvider(url: fontUrl as CFURL),
           let newFont = CGFont(dataProvider) {
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(newFont, &error) {
                print("Error loading Font: \(error)")
            }
        }
    }
}
