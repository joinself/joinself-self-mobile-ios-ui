//
//  Color.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import Foundation
import SwiftUI

extension Color {
    static let defaultGreen: Color = Color(red: 0, green: 0.64, blue: 0.43)
    static let defaultPink: Color = Color(red: 0.98, green: 0.13, blue: 0.57)
    static let defaultGray: Color = Color(red: 0.88, green: 0.88, blue: 0.88)
    static let defaultDark: Color = Color(red: 0.54, green: 0.54, blue: 0.54)
    static let defaultBlack: Color = Color.black
    static let textPrimary: Color = Color(red: 0.05, green: 0.11, blue: 0.26)
    
    static let defaultGrayscale: Color = Color(red: 0.24, green: 0.24, blue: 0.24)
    
    static let defaultPlaceHolder: Color = Color(red: 0.24, green: 0.24, blue: 0.24).opacity(0.3)
    
    /// color warning
    static let defaultYellow: Color = Color(red: 0.8, green: 0.52, blue: 0)
    
    
    static let defaultBlue: Color = Color(red: 0.22, green: 0.58, blue: 1)
    
    /// Quaternary #CC8500
    static let defaultOrange: Color = Color(red: 1, green: 0.75, blue: 0.28)
    
    // Toggle
    static let toggleOff: Color = .defaultGrayscale
    static let toggleOn: Color = .defaultGreen
}


extension CGFloat {
    static let defaultCornerRadius: CGFloat = 10
}
