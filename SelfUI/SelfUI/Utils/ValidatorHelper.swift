//
//  ValidatorHelper.swift
//  SelfUI
//
//  Created by Long Pham on 8/10/24.
//

import Foundation

public struct ValidatorHelper {
    public static func validateName(_ name: String) -> Bool {
        let nameRegex = "^[a-zA-Z]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name) && !name.isEmpty
    }
}
