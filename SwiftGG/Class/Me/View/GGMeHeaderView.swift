//
//  GGMeHeaderView.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/22.
//

import UIKit
import SnapKit

class GGMeHeaderView: UIView {

    //点击回调
    var tapGesBlock:(()->())?
    
    //Model
    var model: GGHeaderModel? {
        didSet
        {
            if let ava = model?.avatar {
                avatar.setImageWith(URL(string: ava), placeholder: UIImage(named: "AppIcon"))
            }
            
            nameLabel.text = model?.name
            positionLabel.text = model?.postion
            desLabel.text = model?.description
        }
    }

    //头像
    lazy var avatar : UIImageView =  {
        let avatar = UIImageView(frame: .zero)
        avatar.image = UIImage(named: "default_avator")
        avatar.layer.cornerRadius = 30
        avatar.layer.masksToBounds = true;
        
        return avatar
    }()
    
    //姓名
    lazy var nameLabel : UILabel = {
        let nameLbl = UILabel(frame:.zero)
        nameLbl.textAlignment  = .left
        nameLbl.font = UIFont.systemFont(ofSize: 22)
        nameLbl.textColor = .white
        return nameLbl
    }()
    
    //职位
    lazy var positionLabel : UILabel =  {
        let positionLbl = UILabel(frame:.zero)
        positionLbl.textAlignment  = .left
        positionLbl.font = UIFont.systemFont(ofSize: 15)
        positionLbl.textColor = .white
        return positionLbl
    }()
    
    //右侧箭头
    lazy var rightArrow : UIImageView = {
        let rightArrowImageView = UIImageView(frame: .zero)
        rightArrowImageView.image = UIImage(named: "right")
        return rightArrowImageView
    }()
    
    //描述
    lazy var desLabel : UILabel = {
        let desLbl = UILabel(frame:.zero)
        desLbl.textAlignment  = .left
        desLbl.font = UIFont.systemFont(ofSize: 12)
        desLbl.textColor = .gray
        return desLbl
    }()
    

    init() {
        super.init(frame: .zero)
        self.setupView()
        self.addGesture()
        self.layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View
extension GGMeHeaderView
{
    func setupView() {
        self.backgroundColor = .orange
        self.addSubview(avatar)
        self.addSubview(nameLabel)
        self.addSubview(positionLabel)
        self.addSubview(rightArrow)
        self.addSubview(desLabel)
    }
    
    func addGesture()
    {
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapGesAction))
        self.addGestureRecognizer(tapGes)
    }
}

// MARK: - layout
extension GGMeHeaderView
{
    func layoutViews() {
       
        avatar.snp_makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(60)
        }
        
        nameLabel.snp_makeConstraints { make in
            make.left.equalTo(avatar.snp_right).offset(5)
            make.top.equalTo(avatar)
            make.right.equalTo(rightArrow.snp_left).offset(-5)
            make.height.equalTo(22)
        }
        
        rightArrow.snp_makeConstraints { make in
            make.right.equalTo(self.snp_right).offset(-10)
            make.width.height.equalTo(16)
            make.top.equalTo(nameLabel)
        }
        
        desLabel.snp_makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(avatar)
            make.height.equalTo(22)
            make.right.equalTo(nameLabel)
        }
    }
    
    // MARK: - Action
    @objc func tapGesAction()
    {
        self.tapGesBlock?()
    }
}
