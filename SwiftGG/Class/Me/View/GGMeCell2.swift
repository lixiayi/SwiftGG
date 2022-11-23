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
        return btn
    }()
    
    lazy var itemTwoBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "default"), for: .normal)
        btn.setTitle("通讯录", for: .normal)
        return btn
    }()
    
    lazy var itemThreedBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "default"), for: .normal)
        btn.setTitle("邮箱", for: .normal)
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
        
        itemTwoBtn.snp_makeConstraints { make in
            make.centerY.equalTo(0)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(60)
        }
        
        itemOneBtn.snp_makeConstraints { make in
            make.right.equalTo(itemTwoBtn.left).offset(100)
            make.centerY.equalTo(itemTwoBtn)
            make.width.top.equalTo(itemTwoBtn)
        }
        
        itemThreedBtn.snp_makeConstraints { make in
            make.left.equalTo(itemTwoBtn.right).offset(100)
            make.centerY.equalTo(itemTwoBtn)
            make.width.top.equalTo(itemTwoBtn)
        }
    }
}
