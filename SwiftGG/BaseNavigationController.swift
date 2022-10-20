//
//  BaseNavigationController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/19.
//

import Foundation

class BaseNavigationController: UINavigationController {
    
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        viewController.hidesBottomBarWhenPushed = true
        // 禁止使用系统自带的滑动手势
        self.interactivePopGestureRecognizer?.isEnabled = true
        
    }
    
    
//    override func popViewController(animated: Bool) -> UIViewController? {
//        
//        let vc = super.popViewController(animated: animated)
//        vc?.hidesBottomBarWhenPushed = false
//        print("[GGDebug] -------popvc----->\(String(describing: vc))");
//        return vc
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.addSubview(navBar)
        self.navigationBar.tintColor = UIColor.blue
        self.navigationBar.setBackgroundImage(UIImage(named: "login_bgview"), for: .default)
    }
    
    fileprivate lazy var navBar:UINavigationBar = {
        
        let bar = UINavigationBar(frame: CGRectMake(0, 0, kScreenWidth, CGFloat(kStatusBarH + kNavgationBarHeight)))
//        bar.tintColor = .black
        bar.setBackgroundImage(UIImage(named: "login_bgview"), for: .default)

        return bar
    }()
    
    
    
}
