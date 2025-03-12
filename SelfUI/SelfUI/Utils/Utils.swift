//
//  Utils.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import Foundation
import UIKit
import AVFoundation
import SwiftUI

class Utils {
    private init() {}
    static let instance = Utils()
    private var isLoadedFonts = false
    
    static func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    static func playCaptureSound() {
        AudioServicesPlaySystemSound(SystemSoundID(1108))
    }
    
    func applyDefaultFonts() {
        if isLoadedFonts == false {
            UIFont.jbs_registerFont(
                withFilenameString: "Barlow-Bold.ttf",
                bundle: Bundle(identifier: mainBundleId)!
            )
            
            UIFont.jbs_registerFont(
                withFilenameString: "Barlow-Regular.ttf",
                bundle: Bundle(identifier: mainBundleId)!
            )
            isLoadedFonts = true
        }
    }
    
    static func hightlightTexts(attributes: [(text: String, font: UIFont, color: UIColor)],
                                inString string: String,
                                font: UIFont,
                                color: UIColor, isMentions: Bool = false) -> NSAttributedString {
        let attributedString =
            NSMutableAttributedString(string: string,
                                    attributes: [
                                        NSAttributedString.Key.font: font,
                                        NSAttributedString.Key.foregroundColor: color])
        
        for attr in attributes {
            let ranges = string.ranges(of: attr.text)
            ranges.forEach { range in
                let convertedRange = NSRange(range, in: string)
                let attribute = [NSAttributedString.Key.font: attr.font, NSAttributedString.Key.foregroundColor: attr.color]
                attributedString.addAttributes(attribute, range: convertedRange)
                if isMentions {
                    attributedString.setAsLink(textToFind: attr.text, linkName: attr.text)
                }
            }
        }
        return attributedString
    }
    
    static let cornerSize: CGSize = CGSize(width: 25, height: 25)
}
