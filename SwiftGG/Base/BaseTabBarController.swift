//
//  BaseTabBarController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/19.
//

import Foundation

class BaseTabBarController: UITabBarController,UITabBarControllerDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置tabBar的barTintColor
        self.tabBar.barTintColor = UIColor.white
        
        //设置tabbar不透明
        self.tabBar.isTranslucent = false
        
        //添加vc
        self.addChildVc()
        
        self.delegate = self
    }
    
    func addChildVc() {
        let firstVC:HomeViewController = HomeViewController()
        let firstNav = 
        BaseNavigationController(rootViewController: firstVC)
        self.setTabBarItem(imageName: "btn_column_normal", selImageName: "btn_column_selected", vc: firstVC as BaseVC, title: "首页")
    
        
        let secondVC:ChatViewController = ChatViewController()
        let secondNav = BaseNavigationController.init(rootViewController: secondVC)
        self.setTabBarItem(imageName: "btn_home_normal", selImageName: "btn_home_selected", vc: secondVC as BaseVC, title: "聊一聊")
        
        
        
        let thirdVC:CloudViewController = CloudViewController()
        let thirdNav = BaseNavigationController.init(rootViewController: thirdVC)
        self.setTabBarItem(imageName: "btn_live_normal", selImageName: "btn_live_selected", vc: thirdVC as BaseVC,title: "云块")
        
        let fourVC:MeViewController = MeViewController();
        let fourNav = BaseNavigationController.init(rootViewController: fourVC)
        self.setTabBarItem(imageName: "btn_user_normal", selImageName: "btn_user_selected", vc: fourVC as BaseVC,title: "我的")
        
        let vcs = [firstNav,secondNav,thirdNav,fourNav]
        self.setViewControllers(vcs, animated: true)
    }
    
    func setTabBarItem(imageName:String, selImageName:String,vc:BaseVC,title:String) -> Void {
       
        let image = UIImage(named:imageName)?.withRenderingMode(.alwaysOriginal)
        
        //解决tabbar选中图片默认为蓝色问题
        let selectedImage = UIImage(named: selImageName)?.withRenderingMode(.alwaysOriginal)
        
        let tabBatItem : UITabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        
        //修改tabbar选中文字的颜色
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.gray]
        tabBatItem.setTitleTextAttributes(attributes, for: .normal)
        
        vc.tabBarItem = tabBatItem
    }

    // MARK: - UITabbarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let vc = viewController
        self.tabBar.isHidden = false
        print(vc)
        
    }
    
    // MARK: - UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let item = item
        print(item)
    }
}



