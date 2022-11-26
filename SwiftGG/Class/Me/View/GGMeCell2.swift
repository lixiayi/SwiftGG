//
//  GGMeCell2.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/23.
//

import UIKit

let GGMeCell2ID = "GGMeCell2ID"

class GGMeCell2: UITableViewCell {

    lazy var itemOneBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "default"), for: .normal)
        btn.setTitle("我的统计", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.titleEdgeInsets = UIEdgeInsets(top: 30, left: -35, bottom: -20, right: -10)
        btn.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 30, right: 0)
        return btn
    }()
    
    lazy var itemTwoBtn : UIButton = {
        var btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "default"), for: .normal)
        btn.setTitle("通讯录", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn = setBtnEdge(btn: btn)
        return btn
    }()
    
    lazy var itemThreedBtn : UIButton = {
        var btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "default"), for: .normal)
        btn.setTitle("邮箱", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn = setBtnEdge(btn: btn)
        return btn
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension GGMeCell2 {
    func setupView()
    {
        contentView.addSubview(itemOneBtn)
        contentView.addSubview(itemTwoBtn)
        contentView.addSubview(itemThreedBtn)
        
        itemOneBtn.snp_makeConstraints { make in
            make.left.equalTo(contentView).offset(50)
            make.centerY.equalTo(contentView)
            make.width.equalTo(60)
            make.height.equalTo(80)
        }
        
        itemTwoBtn.snp_makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.height.equalTo(80)
            make.width.equalTo(60)
        }
        
        
        itemThreedBtn.snp_makeConstraints { make in
            make.right.equalTo(contentView).offset(-50)
            make.centerY.equalTo((contentView))
            make.width.height.equalTo(itemOneBtn)
        }
    }
    
    func setBtnEdge(btn:UIButton) -> (UIButton) {
        btn.titleEdgeInsets = UIEdgeInsets(top: 30, left: -35, bottom: -20, right: -10)
        btn.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 30, right: 0)
        return btn
    }
}
