//
//  RegisterVC.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/22.
//

import UIKit

class RegisterVC: BaseVC {

    // MARK: - Life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.setupUI()
    }
    
    
    func setupUI() {
        self.view.addSubview(backBtn)
    }
    
    // MARK: - Lazy
    fileprivate lazy var backBtn:UIButton = {
        let btn:UIButton = UIButton(type:.custom)
        btn.frame = CGRectMake(16, 30, 22, 22)
        btn.setBackgroundImage(UIImage(named: "icon_login_back"), for: .normal)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.view.addSubview(btn)
        return btn
    }()
    
    // MARK: - Actrion
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
}
