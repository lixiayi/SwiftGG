//
//  UIBarButtonItem-Extenstion.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/30.
//

import UIKit

extension UIBarButtonItem
{
    class func createItem(normalImageName : String, hightlightImageName:String, size:CGSize) -> UIBarButtonItem
    {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: normalImageName), for: .normal)
        btn.setImage(UIImage(named: hightlightImageName), for: .highlighted)
        btn.frame = CGRect(origin: .zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
}
