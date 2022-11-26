//
//  GGSetViewController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/26.
//

import UIKit

class GGSetViewController: BaseVC {

    
    lazy var backgoundImageView : UIImageView = {
        let backgoundImageView = UIImageView(image: UIImage(named: "set_bg_center"))
        backgoundImageView.contentMode = .scaleAspectFit
        return backgoundImageView
    }()
    
    lazy var logoutButton : UIButton = {
        let logoutButton = UIButton(type: .custom)
        logoutButton.layer.cornerRadius = 22;
        logoutButton.layer.masksToBounds = true
        logoutButton.setTitle("退出账号", for: .normal)
        logoutButton.backgroundColor = UIColor.colorWithHex(hex:"#ccffcc")
        logoutButton.setTitleColor(UIColor.blue, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        return logoutButton
    }()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupNavigationBar()
        self.setupViews()
        self.layoutViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        //隐藏底部tabbar
        self.hideTabbar(hide: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //显示底部tabbar
        self.hideTabbar(hide: false)
    }

}

// MARK: - UI
extension GGSetViewController
{
    func setupNavigationBar() {
        self.navigationItem.title = "设置"
        let backItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(backAction))
        
        self.navigationItem.leftBarButtonItem = backItem
    }
    func setupViews() {
        view.addSubview(backgoundImageView)
        view.addSubview(logoutButton)
    }
    
    func layoutViews() {
        backgoundImageView.snp_makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(kNavgationBarHeight)
            make.bottom.equalTo(-kHomeIndicatorH)
        }
        
        logoutButton.snp_makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(44)
            make.bottom.equalTo(-kHomeIndicatorH - 16)
        }
    }
}

// MARK: - Action
extension GGSetViewController
{
    @objc func logoutAction() {
        print("logout...")
    }
    
    @objc func backAction() {
        print("back...")
        self.navigationController?.popViewController(animated: true)
    }
}
