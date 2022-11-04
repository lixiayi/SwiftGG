//
//  GGTools.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/4.
//

import Foundation

class GGTools
{
    static func getCurrentWindow() -> UIWindow?
    {
        if (UIApplication.shared.delegate?.window != nil)
        {
            return (UIApplication.shared.delegate?.window)!
        }
        else
        {
            if #available (iOS 13.0, *)
            {
                let window = UIApplication.shared.windows.first { $0.isKeyWindow}
                if (window != nil)
                {
                    return window
                }
                else
                {
                    return nil
                }
            }
        }
    }
}
