//
//  Fonts.swift
//  SelfUI
//
//  Created by Long Pham on 22/5/24.
//

import SwiftUI

enum FontName: CaseIterable {
    case system
    case barlow
    case sfPro
}

extension Font {
    
    static func getCustomFontName(fontName: FontName, weight: Font.Weight = .regular) -> String? {
        var name = "Barlow-Regular"
        switch fontName {
        case .barlow:
            switch weight {
            case .bold:
                name = "Barlow-Bold"
                
            case .heavy:
                name = "Barlow-ExtraBold"
            default:
                break
            }
        case .sfPro:
            switch weight {
            case .regular:
                name = "SF Pro"
                
                // not support of the weight yet
            default:
                return nil
            }
            
        default:
            break
        }
        
        return name
    }
    
    static func appFont(fontName: FontName = .barlow, size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        guard let fontName = getCustomFontName(fontName: fontName, weight: weight) else {
            return Font.system(size: size, weight: weight, design: design)
        }
        return Font.custom(fontName, size: size)
    }
    
    static let defaultH3: Font = Font.custom("Barlow", size: 36)
    static let defaultNavigationTitle: Font = Font.custom("Barlow", size: 34).weight(.medium)
    static let defaultTitle: Font = SelfUISdk.shared.defaultTitle
    static let customLargeTitle: Font = Font.custom("Barlow-Bold", size: 36, relativeTo: .largeTitle)
    static let defaultLargeTitle: Font = SelfUISdk.shared.defaultLargeTitle
    static let defaultBodyLarge: Font = SelfUISdk.shared.defaultBodyLarge
    static let defaultNormalTitle: Font = Font.custom("Barlow-Bold", size: 25)
    static let defaultBody: Font = SelfUISdk.shared.defaultBody
    
    /// outline text field label
    static let defaultFieldLabel: Font = Font.custom("SF Pro", size: 14)
    static let defaultButton: Font = SelfUISdk.shared.defaultButton
    static let defaultBodyMedium: Font = SelfUISdk.shared.defaultBodyMedium
    static let defaultPin: Font = Font.custom("Barlow", size: 16).weight(.semibold)
    static let defaultTimestamp: Font = Font.custom("Barlow", size: 12).weight(.semibold)
    static let defaultCaption: Font = Font.custom("SF Pro", size: 12).weight(.medium)
    
    static let defaultStatusLabel: Font = Font.custom("SF Pro", size: 12).weight(.medium)
    
    /// Power by
    static let defaultFootnote: Font = Font.custom("Barlow", size: 15)
    
    
    public static let navigationTitle: Font = Font.custom("Barlow-Bold", size: 25)
}
