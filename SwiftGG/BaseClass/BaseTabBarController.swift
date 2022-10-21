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
        self.tabBar.barTintColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.2, alpha: 1)
        
        //添加vc
        self.addChildVc()
        
        self.delegate = self
    }
    
    func addChildVc() {
        let firstVC:FirstViewController = FirstViewController()
        let firstNav = 
        BaseNavigationController(rootViewController: firstVC)
        self.setTabBarItem(imageName: "btn_column_normal", selImageName: "btn_column_selected", vc: firstVC as BaseVC, title: "列表")
    
        
        let secondVC:SecondViewController = SecondViewController()
        let secondNav = BaseNavigationController.init(rootViewController: secondVC)
        self.setTabBarItem(imageName: "btn_home_normal", selImageName: "btn_home_selected", vc: secondVC as BaseVC, title: "主页")
        
        
        
        let thirdVC:ThirdViewController = ThirdViewController()
        let thirdNav = BaseNavigationController.init(rootViewController: thirdVC)
        self.setTabBarItem(imageName: "btn_live_normal", selImageName: "btn_live_selected", vc: thirdVC as BaseVC,title: "直播")
        
        let fourVC:FourViewController = FourViewController();
        let fourNav = BaseNavigationController.init(rootViewController: fourVC)
        self.setTabBarItem(imageName: "btn_user_normal", selImageName: "btn_user_selected", vc: fourVC as BaseVC,title: "我的")
        
        let vcs = [firstNav,secondNav,thirdNav,fourNav]
        self.setViewControllers(vcs, animated: true)
    }
    
    func setTabBarItem(imageName:String, selImageName:String,vc:BaseVC,title:String) -> Void {
       
        let image = UIImage(named:imageName)?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: UIImage.ResizingMode.stretch)
        let selectedImage = UIImage(named: selImageName)?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: UIImage.ResizingMode.stretch)
        
        let tabBatItem : UITabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        
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



