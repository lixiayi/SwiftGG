//
//  UIColor+Extension.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/22.
//

import Foundation


extension UIColor
{
    static func colorWithHex(hex:String) -> UIColor? {
        return UIColor.colorWithHexAndAlpha(hex: hex, alpha: 1.0)
    }
    
    static func colorWithHexAndAlpha(hex:String, alpha:CGFloat) -> UIColor? {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }
            if ((cString.count) != 6) {
                return nil
            } else {
                var rgbValue:UInt64 = 0
                Scanner(string: cString).scanHexInt64(&rgbValue)
                return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                               green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                               blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                               alpha: alpha)
            }
    }
}
