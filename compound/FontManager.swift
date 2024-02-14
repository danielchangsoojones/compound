//
//  MyFont.swift
//  compound
//
//  Created by Daniel Jones on 2/13/24.
//

import Foundation
import UIKit

class FontManager {
    static let shared = FontManager()
        
        // Define your fonts here
        enum AppFont: String {
            case regular = "HelveticaNeue"
            case bold = "HelveticaNeue-Bold"
            case italic = "HelveticaNeue-Italic"
            // Add other font styles as needed
        }
        
        private init() {} // Private initialization to ensure singleton usage
        
        func font(forStyle style: AppFont, size: CGFloat) -> UIFont {
            // Attempt to return the custom font
            if let customFont = UIFont(name: style.rawValue, size: size) {
                return customFont
            }
            
            // Fallback to system font if the custom font fails to load
            return UIFont.systemFont(ofSize: size)
        }
}
