//
//  String+Extension.swift
//  SelfUI
//
//  Created by Long Pham on 21/5/24.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        if SelfUISdk.shared.customization == true, let bundle = Bundle(identifier: mainBundleId) {
            return NSLocalizedString(self, bundle: bundle ,comment: "")
        }
        
        return NSLocalizedString(self, comment: "")
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        guard let from = range.lowerBound.samePosition(in: utf16) else {
            return nil
        }
        
        guard let to = range.upperBound.samePosition(in: utf16) else {
            return nil
        }
        
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

extension Int {
    var digits: [Int] {
        return String(self).compactMap { Int(String($0)) }
    }
}

extension NSMutableAttributedString {
    func setAsLink(textToFind:String, linkName:String) {
        print("SetAsLink: \(textToFind):\(linkName)")
        let ranges = self.string.ranges(of: textToFind)
        let foundRange = self.mutableString.range(of: textToFind)
        
        ranges.forEach { rangeIndex in
            if let range = self.string.nsRange(from: rangeIndex) {
                self.addAttribute(NSAttributedString.Key.link, value: linkName, range: range)
            }
        }
    }
}


extension UIFont {
    static func jbs_registerFont(withFilenameString filenameString: String, bundle: Bundle) {
        
        guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil) else {
            print("UIFont+:  Failed to register font - path for resource not found.")
            return
        }
        
        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("UIFont+:  Failed to register font - font data could not be loaded.")
            return
        }
        
        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("UIFont+:  Failed to register font - data provider could not be loaded.")
            return
        }
        
        guard let font = CGFont(dataProvider) else {
            print("UIFont+:  Failed to register font - font could not be loaded.")
            return
        }
        
        var errorRef: Unmanaged<CFError>? = nil
        if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
            print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }
    
}
