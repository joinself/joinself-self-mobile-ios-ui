//
//  String+Extension.swift
//  SelfUI
//
//  Created by Long Pham on 21/5/24.
//

import Foundation

extension String {
    var localized: String {
        guard let bundle = Bundle(identifier:"com.joinself.mobile.ui.SelfUI") else {
            return NSLocalizedString(self, comment: "")
        }
        
        return NSLocalizedString(self, bundle: bundle ,comment: "")
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
