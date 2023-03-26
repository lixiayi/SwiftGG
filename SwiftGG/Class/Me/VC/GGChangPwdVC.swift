//
//  GGChangPwdVC.swift
//  SwiftGG
//
//  Created by stoicer on 2023/3/26.
//  修改密码

import UIKit

class GGChangPwdVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white;

        //title
        navigationItem.title = "修改密码";
        
        //设置返回按钮
        let backItem = UIBarButtonItem(image: UIImage(named: "back"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.hideTabbar(hide: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc func backAction()  {
        navigationController?.popViewController(animated: true)
    }
}


