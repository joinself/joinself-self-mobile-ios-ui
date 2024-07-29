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
    static let defaultTitle: Font = Font.system(size: 36).bold()//Font.custom("Barlow-Bold", size: 36)
    static let defaultBody: Font = Font.custom("Barlow", size: 17)
}
