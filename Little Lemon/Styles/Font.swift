//
//  Font.swift
//  Little Lemon
//
//  Created by Amine on 22/11/2024.
//

import SwiftUICore

extension Font {
    static func displayFont() -> Font {
        return Font.custom("Markazi Text", size: 36).weight(.medium)
    }
    
    static func subTitleFont() -> Font {
        return Font.custom("Markazi Text", size: 32)
    }
    
    static func leadText() -> Font {
        return Font.custom("Karla", size: 16).weight(.medium)
    }
    
    static func regularText() -> Font {
        return Font.custom("Markazi Text", size: 18)
    }
    
    static func sectionTitle() -> Font {
        return Font.custom("Karla", size: 18).weight(.black)
    }
    
    static func sectionCategories() -> Font {
        return Font.custom("Karla", size: 16).weight(.heavy)
    }
    
    static func paragraphText() -> Font {
        return Font.custom("Karla", size: 14)
    }
    
    static func highlightText() -> Font {
        return Font.custom("Karla", size: 14).weight(.medium)
    }
}
