//
//  FiveViewController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/19.
//

import UIKit

class FiveViewController: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = UIColor.purple
        
        let btn:UIButton = UIButton(type:.custom)
        btn.frame = CGRectMake(self.view.bounds.size.width/2 - 60, 200, 120, 44)
        btn.backgroundColor = UIColor.blue
        btn.setTitle("返回", for: .normal)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        self.view.addSubview(btn)
        
        let sixbtn:UIButton = UIButton(type:.custom)
        sixbtn.frame = CGRectMake(self.view.bounds.size.width/2 - 60, 300, 120, 44)
        sixbtn.backgroundColor = UIColor.blue
        sixbtn.setTitle("进入six", for: .normal)
        sixbtn.addTarget(self, action: #selector(enterSix), for: .touchUpInside)
        self.view.addSubview(sixbtn)
        
        self.navigationItem.title = "第五个"

        //添加导航栏左侧返回按钮
        guard let image = UIImage(named: "back")  else { return  }
        let rederImage = image.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: rederImage, style: .plain, target: self, action: #selector(backAction))
        
        //添加导航栏右侧返回按钮
        guard let image1 = UIImage(named: "more")  else { return  }
        let renderImage = image1.withRenderingMode(.alwaysOriginal)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: renderImage, style: .plain, target: self, action:#selector(rightAction))
        
        print(self.navigationItem.rightBarButtonItem!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func backAction() {
        print("返回")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func rightAction(){
        print("right action")
    }
    
    @objc func enterSix(){
        let sixvc = SixViewController()
        self.navigationController?.pushViewController(sixvc, animated: true)
    }
    
    
    @objc func btnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
