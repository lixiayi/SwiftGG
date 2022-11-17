//
//  LoginDomainListVC.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/30.
//

import UIKit

class LoginDomainListVC: BaseVC,UITableViewDataSource,UITableViewDelegate {
    var dataArr:[LoginModel] = []
    
    lazy var bgImageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        imgView.image = UIImage(named: "set_bg")
        return imgView
    }()
    
    lazy var titleLabel : UILabel = {
        
        
        let lbl = UILabel(frame: CGRect(x: 0, y: kStatusBarH, width: kScreenWidth, height: 44))
        lbl.text = "选择企业"
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    //tableView
    lazy var tableView : UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: kNavgationBarHeight + kStatusBarH, width: kScreenWidth, height: kScreenHeight), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.register(LoginDomainCell.self, forCellReuseIdentifier: kLoginDomainCellID)
        //设置tableView背景透明
        tableView.backgroundColor = .clear
        //去掉分割线
        tableView.separatorColor = UIColor.clear
       
        return tableView
    }()
    
    lazy var headerView : UIView = {
        let view = UIView(frame:  CGRect(x: 0, y: 0, width: 130, height: 44))
        view.backgroundColor = .clear
        view.addSubview(headerLabel)
        return view
    }()
    
    lazy var headerLabel : UILabel = {
        let header = UILabel(frame: CGRect(x: 20, y: 0, width: 130, height: 44))
        header.text = "进入你的企业"
        header.font = UIFont.systemFont(ofSize: 19)
        header.textColor = UIColor.white
        header.textAlignment = .left
        return header
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //添加视图
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupUI() {
        //添加背景图
        view.addSubview(bgImageView)
        //添加tableView
        view.addSubview(tableView)
        //添加自己的标题
        view.addSubview(titleLabel)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName:nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginDomainListVC {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LoginDomainCell = tableView.dequeueReusableCell(withIdentifier: kLoginDomainCellID) as! LoginDomainCell
        cell.loginM = dataArr[indexPath.row]
        cell.latestLabel.isHidden = (indexPath.row != 0)
        cell.cellc = {[weak self](model) -> Void in
            
            self?.doRequestRouter(model: cell.loginM!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: LoginDomainCell = tableView.dequeueReusableCell(withIdentifier: kLoginDomainCellID) as! LoginDomainCell
       
        
        //获取当前点击的model
        let loginM = dataArr[indexPath.row]
        cell.loginM = loginM
        cell.cellc = {[weak self](model) -> Void in
            self?.doRequestRouter(model: cell.loginM!)
        }
        
        //调用执行右侧点击按钮的方法
        cell.rightBtnClick()
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func doRequestRouter(model:LoginModel) {
        let url = GG_WisdomBossUrl + GG_HotTub_Code_CompanyInfoByRouter
        
        NetworkTool.requestGruopInfo(url: url, parameter: ["companyName" : model.domain!]) { data in
            guard let aData = data as? [String : NSObject] else { return }
            guard let result = aData["result"] as? [String:NSObject] else { return }
            print(result)
            let ud =  UserDefaults.standard
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: result, requiringSecureCoding: true)
                ud.setValue(data, forKey: kCompanyInfoKey)
            }
            catch {
                print(error)
            }
            
            
            //开始登录
            self.doLoginWithModel(model: model)
            
        } failCallBack: { messageInfo in
                
        }
    }
    
    
    func doLoginWithModel(model:LoginModel) {
        //使用切换关联账号的方式登录
        let ud =  UserDefaults.standard
        let tempData = ud.object(forKey: kCompanyInfoKey)
        let tempDic = NSKeyedUnarchiver.unarchiveObject(with: tempData as! Data, exception: nil) as! [String: NSObject]
        
        let chatserverApi = tempDic["chatserver_api"] as! String?
        let chatserverId = tempDic["chatserver_id"]
        let url = chatserverApi! +  GG_Code_LinkLogin
        
        
        let bundleVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        
        
        let params = ["platform_type" : 2,
                      "im_user_name" : model.im_user_name ?? "",
                      "im_user_pwd" : model.im_user_pwd ?? "" ,
                      "chatserver_id_from" : chatserverId as Any,
                      "im_user_name_from" : model.im_user_name ?? "",
                      "platform_token" : "123",
                      "platform_sys_version" : UIDevice.current.systemVersion,
                      "platform_app_version" : bundleVersion as Any]

        NetworkTool.requestLastLoginWithHeader(url: url, parameter: params, header: GG_NetWorkTool_Headers) { data in
            //缓存数据
            GGDataManager.saveUserInfo(dic: data as! [String : AnyObject])
            
            //进入rootVC
            let mainTabbarController = RootViewController()
            let window = GGTools.getCurrentWindow()
            window?.rootViewController = mainTabbarController;
            
            
        } failCallBack: { messageInfo in
            print("请求失败:\(messageInfo)")
        }
    }
}
