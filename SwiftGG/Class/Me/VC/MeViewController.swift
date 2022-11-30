//
//  MeViewController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/19.
//

import UIKit

class MeViewController: BaseVC {
    
    // MARK: - 数据源
    lazy var dataArray : [[String : Any]] = [[String : Any]]()
    lazy var imageArray : [[String : Any]] = [[String : Any]]()
    
    var model: GGHeaderModel? = GGHeaderModel()
    
    var viewModel : GGMeViewModel? = GGMeViewModel()

    lazy var headerView : GGMeHeaderView? = {
        let header = GGMeHeaderView()
        header.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 160)
        header.model = model
    
        return header
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.tableHeaderView = headerView;
        tableView.register(GGMeCell1.self, forCellReuseIdentifier: GGMeCell1ID)
        tableView.register(GGMeCell2.self, forCellReuseIdentifier: GGMeCell2ID)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        initData()
        setupView()
        layoutViews()
        
        //请求个人名片
        loadPersonCardData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - 初始化数据
extension MeViewController
{
    func initData()  {
        //添加模型数据
        model?.postion = "中国GG信息/Line开发部"
        model?.name = "stoicer"
        model?.description = "这个家伙很难，什么都没留下"
        
        //添加标题数据
        dataArray.append( ["0" : "GG钱包"])
        dataArray.append( ["0" : "我的统计", "1":"通讯录", "2" : "邮箱"])
        dataArray.append( ["0" : "缓存清理", "1":"网络状态", "2" : "关联账号", "3" : "设置"])
        dataArray.append( ["0" : "我要反馈", "1":"关于", "2" : "帮助中心"])
        
        //添加图片数据
        imageArray.append(["0" : "company_mine_wallet"])
        imageArray.append(["0" : "company_mine_statistics",
                           "1":"company_mine_switch_account",
                           "2" : "company_mine_email"])
        imageArray.append(["0" : "company_mine_clear_cache",
                           "1":"company_mine_network_status",
                           "2" : "company_mine_switch_account" ,
                           "3" : "personal_mine_setting"])
        imageArray.append(["0" : "company_mine_feedback",
                           "1":"company_mine_about",
                           "2" : "company_mine_help"])
    }
}


// MARK: - View
extension MeViewController
{
    func setupView()
    {
        view.addSubview(tableView)
    }
}

// MARK: - lazy
extension MeViewController
{
    func layoutViews()
    {
        tableView.snp_makeConstraints { make in
            make.top.equalTo(-kNavgationBarHeight)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-kHomeIndicatorH)
        }
    }
}


// MARK: - UITableViewDelegate

extension MeViewController : UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section || 1 == section  {
            return 1
        }
        else if 2 == section
        {
            return 4
        }
        else
        {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: GGMeCell2ID) as! GGMeCell2

            let tj = dataArray[indexPath.section]["0"] as? String
            cell2.itemOneBtn.setImage(UIImage(named: "company_mine_statistics"), for: .normal)
            cell2.itemOneBtn.setTitle(tj, for: .normal)
             
            let txl = dataArray[indexPath.section]["1"] as? String
            cell2.itemTwoBtn.setImage(UIImage(named: "company_mine_switch_account"), for: .normal)
            cell2.itemTwoBtn.setTitle(txl, for: .normal)
            
            let yx = dataArray[indexPath.section]["2"] as? String
            cell2.itemThreedBtn.setImage(UIImage(named: "company_mine_email"), for: .normal)
            cell2.itemThreedBtn.setTitle(yx, for: .normal)
            
            return  cell2
        }
        else
        {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: GGMeCell1ID) as! GGMeCell1
            
            //title
            let title = dataArray[indexPath.section][String(indexPath.row)] as? String
            cell1.titleLabel.text = title
            
            //image
            let image = imageArray[indexPath.section][String(indexPath.row)] as? String
            cell1.iconImageView.image = UIImage(named: image!)
            
            return  cell1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                return 80;
            }
            else
            {
                return GGMeCellH
            }
        }
        else {
            return GGMeCellH
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sec = indexPath.section
        let row = indexPath.row
        if 2 == sec {
            
            //设置
            switch row {
            case 0:
                print("0")
            case 1:
                print("1")
            case 2:
                print("2")
            case 3:
            
                let vc = GGSetViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            
                
            default:
                print("default select")
            }
        }
    }
}

// MARK: - 请求数据
extension MeViewController
{
    // MARK: - loadData
    func loadPersonCardData() {
        GGMeViewModel.loadPersonCardData { data in
        
            guard let dict = data["data"] as? [String : Any] else { return }
            
            
            print(dict);
            
        }
    }
}

