//
//  Color.swift
//  SelfUI
//
//  Created by Long Pham on 28/5/24.
//

import Foundation
import SwiftUI

extension Color {
    // MARK:  Brand colors
    /// like pink/red
    public static let colorPrimary: Color = Color(hex: "FB2191")
    
    /// green
    public static let colorSecondary: Color = Color(hex: "00C887")
    
    /// light blue
    public static let colorTertiary: Color = Color(hex: "71B4FF")
    
    /// light yellow
    public static let colorQuaternary: Color = Color(hex: "FFC048")
    
    /// gray
    public static let colorQuinary: Color = Color(hex: "919397")
    
    // MARK: Inteface
    public static let backgroundPrimary: Color = Color(hex: "FFFFFF")
    public static let backgroundSecondary: Color = Color(hex: "000000")
    public static let colorTextPrimary: Color = Color(hex: "0E1C42")
    public static let colorTextSecondary: Color = Color(hex: "FFFFFF")
    
    
    // MARK: Greyscale
    public static let greyScaleDark: Color = Color(hex: "3E3E3E")
    public static let greyScaleMid: Color = Color(hex: "8A8A8A")
    public static let greyScaleLight: Color = Color(hex: "E1E1E1")
    
    // MARK: Semantic
    public static let colorError: Color = Color(hex: "FB2191")
    public static let colorSuccess: Color = Color(hex: "00C887")
    public static let colorInfo: Color = Color(hex: "71B4FF")
    public static let colorWarning: Color = Color(hex: "FFC048")
    
    public static let defaultGreen: Color = Color(red: 0, green: 0.64, blue: 0.43)
    public static let defaultPink: Color = Color(red: 0.98, green: 0.13, blue: 0.57)
    static let defaultError: Color = .defaultPink
    
    /// Message Cell
    static let defaultGray: Color = Color(red: 0.88, green: 0.88, blue: 0.88)
    static let PrimaryOverlay: Color = Color(red: 0, green: 0.37, blue: 0.98).opacity(0.1)
    
    static let defaultGrayBackground: Color = Color(red: 0.98, green: 0.98, blue: 0.98)
    static let defaultDark: Color = Color(red: 0.54, green: 0.54, blue: 0.54)
    static let defaultBlack: Color = Color.black
    static let defaultOverlay: Color = backgroundSecondary.opacity(0.5)
    
    // MARK: Text
    /// #0E1C42
    public static let textPrimary: Color = Color(red: 0.05, green: 0.11, blue: 0.26)
    static let textSecondary: Color = .white
    static let textSubtitle: Color = Color(red: 0.38, green: 0.42, blue: 0.48)
    static let textTimestamp: Color = Color(red: 0.65, green: 0.67, blue: 0.71)
    
    // MARK: Background
    
    static let defaultGrayscale: Color = Color(red: 0.24, green: 0.24, blue: 0.24)
    
    static let defaultPlaceHolder: Color = Color(red: 0.24, green: 0.24, blue: 0.24).opacity(0.3)
    
    /// color warning
    static let defaultYellow: Color = colorQuaternary
    
    
    static let defaultBlue: Color = Color(red: 0.22, green: 0.58, blue: 1)
    static let defaultLightBlue: Color = Color(red: 0.72, green: 0.85, blue: 1)
    
    /// Quaternary #CC8500
    static let defaultOrange: Color = Color(red: 1, green: 0.75, blue: 0.28)
    
    // Toggle
    static let toggleOff: Color = .defaultGrayscale
    static let toggleOn: Color = .defaultGreen
}


extension CGFloat {
    static let defaultCornerRadius: CGFloat = 10
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        let _ = scanner.scanHexInt64(&hexNumber)
        
        let r = Double((hexNumber & 0xff0000) >> 16) / 255
        let g = Double((hexNumber & 0x00ff00) >> 8) / 255
        let b = Double(hexNumber & 0x0000ff) / 255
        
        self.init(red: r, green: g, blue: b)
    }
}
