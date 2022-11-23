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
        header.model = model
    
        return header
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        model?.postion = "中国GG信息/Line开发部"
        model?.name = "stoicer"
        model?.description = "这个家伙很难，什么都没留下"
        
        self.setupView()
        self.layoutViews()
    }
}


// MARK: - View
extension MeViewController
{
    func setupView()
    {
        view.addSubview(headerView)
    }
}

// MARK: - lazyt

extension MeViewController
{
    func layoutViews()
    {
        headerView.snp_makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(view).offset(-88)
            make.height.equalTo(160)
        }
    }
}
