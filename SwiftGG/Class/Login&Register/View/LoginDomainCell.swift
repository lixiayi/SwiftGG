//
//  LoginDomainCell.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/30.
//

import UIKit
import Kingfisher
import SnapKit

let kLoginDomainCellID = "kLoginDomainCellID"

typealias cellClick = (LoginModel) -> ()

class LoginDomainCell: UITableViewCell {
    
    var cellc : cellClick?
    
    var loginM : LoginModel? {
        didSet {
            logoImageView.setImageWith(URL(string: (loginM?.recommend_image)!), placeholder: nil)
            nameLabel.text = loginM!.domain
        }
    }
    
    //整个背景view
    lazy var bgView : UIView = {
        let view = UIView(frame: CGRectMake(16, 5, kScreenWidth, 70))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    //透明背景条
    lazy var topView : UIView = {
        let view = UIView(frame: CGRectMake(16, 0, kScreenWidth, 10))
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    //图标
    lazy var logoImageView : UIImageView = {
        let logo = UIImageView(frame: CGRectMake(16, 5, 80, 30))
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    lazy var nameLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 5, width: 100, height: 30))
        label.textAlignment = .left
        label.text = "中国亦云信息"
        label.textColor = UIColor.colorWithHex(hex: "0x333333")
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    lazy var latestLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: kScreenWidth - 100, y: 5, width: 60, height: 30))
        label.textAlignment = .right
        label.text = "最近登录"
        label.textColor = UIColor.blue
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    lazy var righBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRectMake(kScreenWidth - 20, 5, 16, 16)
        btn.setImage(UIImage(named: "right"), for: .normal)
        btn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //选择状态
        selectionStyle = .none
        
        //添加视图
        self.setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        //设置cell透明
        backgroundColor = .clear
        
        contentView.addSubview(bgView)
        bgView.addSubview(topView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(latestLabel)
        bgView.addSubview(righBtn)
        
        bgView.snp_makeConstraints { make in
            make.left.equalTo(contentView.snp_left).offset(16)
            make.right.equalTo(contentView.snp_right).offset(-16)
            make.centerY.equalTo(contentView).offset(0)
            make.top.equalTo(contentView.snp_top).offset(5)
        }
        
        topView.snp.makeConstraints { make in
            make.left.right.top.equalTo(0)
            make.height.equalTo(10)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalTo(contentView).offset(0)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp_right).offset(10)
            make.centerY.equalTo(logoImageView)
            make.width.equalTo(100)
        }
        
        righBtn.snp.makeConstraints { make in
            make.right.equalTo(bgView.snp_right).offset(0)
            make.centerY.equalTo(logoImageView)
            make.width.height.equalTo(20)
        }
        
        latestLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.width.equalTo(80)
            make.right.equalTo(righBtn.snp_left).offset(0)
        }
    }
    
    @objc func rightBtnClick()
    {
        cellc!(loginM!)
    }
     
}
