//
//  UIView+Extension.swift
//  SwiftGG
//
//  Created by stoicer on 2020/12/26.
//

import UIKit

extension UIView
{
    func cornerWith(rectCorner:UIRectCorner, radius:CGFloat) {
        let sharpLayer: CAShapeLayer = CAShapeLayer()
        sharpLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), byRoundingCorners: rectCorner, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = sharpLayer
    }
}


