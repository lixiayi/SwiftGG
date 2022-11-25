//
//  MeViewController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/19.
//

import UIKit

class MeViewController: BaseVC {
    
    var model: GGHeaderModel? = GGHeaderModel()

    lazy var headerView : GGMeHeaderView = {
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
        
    }
}

extension MeViewController
{
    func initData()  {
        model?.postion = "中国GG信息/Line开发部"
        model?.name = "stoicer"
        model?.description = "这个家伙很难，什么都没留下"
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
            make.top.bottom.left.right.equalTo(0)
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
        else if 1 == section
        {
            return 4
        }
        else
        {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: GGMeCell1ID) as! GGMeCell1
            cell1.iconImageView.image = UIImage(named: "company_mine_wallet")
            cell1.titleLabel.text = "GG钱包"
            return  cell1
        }
        else if indexPath.section == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: GGMeCell2ID) as! GGMeCell2
            cell2.itemOneBtn.setImage(UIImage(named: "company_mine_statistics"), for: .normal)
            cell2.itemOneBtn.setTitle("我的统计", for: .normal)
            
            cell2.itemTwoBtn.setImage(UIImage(named: "company_mine_switch_account"), for: .normal)
            cell2.itemTwoBtn.setTitle("通讯录", for: .normal)
            
            cell2.itemThreedBtn.setImage(UIImage(named: "company_mine_email"), for: .normal)
            cell2.itemThreedBtn.setTitle("邮箱", for: .normal)
            
            return  cell2
        } else if indexPath.section == 2 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: GGMeCell1ID) as! GGMeCell1
            
            if indexPath.row == 0
            {
                cell1.iconImageView.image = UIImage(named: "company_mine_clear_cache")
                cell1.titleLabel.text = "清理缓存"
            }
            else if indexPath.row == 1
            {
                cell1.iconImageView.image = UIImage(named: "company_mine_network_status")
                cell1.titleLabel.text = "网络状态"
            }
            else if indexPath.row == 2
            {
                cell1.iconImageView.image = UIImage(named: "company_mine_switch_account")
                cell1.titleLabel.text = "关联账号"
            }
            else if indexPath.row == 3
            {
                cell1.iconImageView.image = UIImage(named: "personal_mine_setting")
                cell1.titleLabel.text = "设置"
            }
            
            return  cell1
        }
        else if indexPath.section == 3 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: GGMeCell1ID) as! GGMeCell1
            
            if indexPath.row == 0
            {
                cell1.iconImageView.image = UIImage(named: "company_mine_feedback")
                cell1.titleLabel.text = "我要反馈"
            }
            else if indexPath.row == 1
            {
                cell1.iconImageView.image = UIImage(named: "company_mine_about")
                cell1.titleLabel.text = "关于"
            }
            else if indexPath.row == 2
            {
                cell1.iconImageView.image = UIImage(named: "company_mine_help")
                cell1.titleLabel.text = "帮助中心"
            }
            return  cell1
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                return 80;
            }
            else
            {
                return 44
            }
        }
        else {
            return 44
        }
    }
}
