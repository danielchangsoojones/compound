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

class ColorHelper {
    static func color(fromHex hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
