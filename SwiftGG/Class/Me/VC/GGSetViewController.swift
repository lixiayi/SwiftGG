//
//  GGSetViewController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/26.
//

import UIKit
import PKHUD

class GGSetViewController: BaseVC {

    fileprivate lazy var dataArray : [[String : Any]] = {
        
        var dataArray = [[String : String]]()
        dataArray.append(["image" : "set_account_psw", "title" : "修改密码"])
        dataArray.append(["image" : "set_assistant_notice", "title" : "小慧助手通知"])
        dataArray.append(["image" : "set_newmessage_notice", "title" : "通知设置"])
        dataArray.append(["image" : "set_device_record", "title" : "设备管理"])
        dataArray.append(["image" : "set_reject_answer", "title" : "拒听设置"])
        dataArray.append(["image" : "set_account_user_info_list", "title" : "个人信息手机清单"])
        dataArray.append(["image" : "set_account_other_list", "title" : "第三方信息共享清单"])
        dataArray.append(["image" : "set_account_cancel", "title" : "注销账号"])
        return dataArray
        
    }()
    
    lazy var backgoundImageView : UIImageView = {
        let backgoundImageView = UIImageView(image: UIImage(named: "set_bg_center"))
        backgoundImageView.contentMode = .scaleAspectFit
        return backgoundImageView
    }()
    
    
    fileprivate lazy var tableView : UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: kNavgationBarHeight, width: kScreenWidth, height: kScreenHeight - 100), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(GGSetCell.self, forCellReuseIdentifier: kGGSetCellID)
        return tableView

    }()
    
    
    lazy var logoutButton : UIButton = {
        let logoutButton = UIButton(type: .custom)
        logoutButton.layer.cornerRadius = 22;
        logoutButton.layer.masksToBounds = true
        logoutButton.setTitle("退出账号", for: .normal)
        logoutButton.backgroundColor = kAppThemeColor
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        return logoutButton
    }()
    
    // MARK: - Life
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

// MARK: - UITableViewDataSource & UITableViewDelegate
extension GGSetViewController : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kGGSetCellID) as! GGSetCell
        
        let row = indexPath.row
        let dict = dataArray[row] as? [String : String]

        cell.imgView.image = UIImage(named: dict?["image"] ?? "default_avatar")
        cell.titleLbl.text = dict?["title"]
        //dict -> model
        cell.model = GGSetModel.deserialize(from: dict, designatedPath: nil)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
}

// MARK: - UI
extension GGSetViewController
{
    func setupNavigationBar() {
        
        //设置title
        navigationItem.title = "设置"
        
        //设置返回item
        let backItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backItem
//
        //设置右侧item
        let rightItem =  UIBarButtonItem.createItem(normalImageName: "more", hightlightImageName: "more", size: CGSize(width: 40, height: 30))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func setupViews() {
        view.addSubview(backgoundImageView)
        view.addSubview(tableView)
        view.addSubview(logoutButton)
    }
    
    func layoutViews() {
        backgoundImageView.snp_makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(kNavgationBarHeight)
            make.bottom.equalTo(-kHomeIndicatorH)
        }
        
        tableView.snp_makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(logoutButton.snp_top).offset(0)
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
        GGSetViewModel.loadData {
            print("退出登录成功")
            HUD.flash(.success)
            let loginViewController:LoginVC = LoginVC()
            let rootNav:BaseNavigationController = BaseNavigationController(rootViewController: loginViewController)
            let window = GGTools.getCurrentWindow()
            window?.rootViewController = rootNav;
            window?.makeKeyAndVisible()
        }
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
