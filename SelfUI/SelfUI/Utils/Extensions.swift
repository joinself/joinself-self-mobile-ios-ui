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
}

extension Int {
    var digits: [Int] {
        return String(self).compactMap { Int(String($0)) }
    }
}

