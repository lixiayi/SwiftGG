//
//  BaseNavigationController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/19.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //Push时隐藏系统的tabbar
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        print("[GGDebug] -------popvc----->\(String(describing: vc))");
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏的颜色 在iOS15系统后需要这么设置
        if #available(iOS 15, *) {
            let apperance = UINavigationBarAppearance()
            //添加背景色
            apperance.backgroundColor = UIColor.colorWithHex(hex:"#ccffcc")
            apperance.shadowColor = nil
            apperance.shadowImage = UIImage()
            
            //设置字体颜色
            apperance.titleTextAttributes = [.foregroundColor : UIColor.white]
            
            //设置正常和滑动时导航栏的样式
            navigationBar.standardAppearance = apperance
            navigationBar.scrollEdgeAppearance = apperance
            navigationBar.compactAppearance = apperance
            navigationBar.compactScrollEdgeAppearance = apperance
        }
        else
        {
            //兼容旧系统
            self.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
            self.navigationBar.barTintColor = UIColor.colorWithHex(hex:"#ccffcc")
        }
        
        
        //自定义全屏右滑pop手势 https://www.jianshu.com/p/2e8d332c60ff?_t_t_t=0.9927985240701174
        guard let systemPopGesture = interactivePopGestureRecognizer else { return  }
        guard let gesView = systemPopGesture.view else { return  }
        let target = systemPopGesture.value(forKey: "_targets") as? [NSObject]
        guard let targetOjbc = target?.first else { return  }
        
        //取出targe
        guard let target = targetOjbc.value(forKey: "target") else { return  }
        
        //取出action
        let action = Selector(("handleNavigationTransition:"))
        
        //创建自己的全屏Pop手势
        let myPopGes = UIPanGestureRecognizer(target: target, action: action)
        gesView.addGestureRecognizer(myPopGes)
        myPopGes.delegate = self
        
        //设置系统自带Pop手势失效
        self.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    //防止导航控制器只有一个rootViewController时触发手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        //解决与左滑手势冲突
        let translation : CGPoint = (gestureRecognizer as! UIPanGestureRecognizer).translation(in: gestureRecognizer.view)
        if (translation.x <= 0)
        {
            return false
        }
        
        // 过滤执行过渡动画时的手势处理
        if ((self.value(forKey: "_isTransitioning") as! NSNumber).boolValue)
        {
            return false
        }
    
        return self.viewControllers.count == 1 ? false : true
    }
}
