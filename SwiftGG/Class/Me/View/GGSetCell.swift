//
//  GGSetCell.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/27.
//

import UIKit

let kGGSetCellID = "kGGSetCellID"

class GGSetCell: UITableViewCell {
    
   // MARK: - 模型数据
    var model : GGSetModel? {
        didSet
        {
            imgView.image = UIImage(named: model?.image ?? "default_avatar")
            titleLbl.text = model?.title
        }
    }


    lazy var imgView : UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var titleLbl : UILabel = {
        let titleLbl = UILabel(frame:.zero)
        titleLbl.font = UIFont.systemFont(ofSize: 18)
        return titleLbl
    }()
    
    fileprivate lazy var rightButton : UIButton = {
        let rightButton : UIButton = UIButton(type: .custom)
        rightButton.setImage(UIImage(named: "right"), for: .normal)
        return rightButton
    }()
    
    fileprivate lazy var lineView : UIView = {
        let lineView = UIView(frame: .zero)
        lineView.backgroundColor = kCellSepColor
        return lineView
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        layoutViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension GGSetCell
{
    func setupViews() {
        selectionStyle = .none
        contentView.addSubview(imgView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(rightButton)
        contentView.addSubview(lineView)
    }
    
    func layoutViews() {
        imgView.snp_makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(44)
        }
        
        titleLbl.snp_makeConstraints { make in
            make.left.equalTo(imgView.snp_right).offset(16)
            make.centerY.equalTo(imgView)
            make.right.equalTo(rightButton.snp_left).offset(-16)
        }
        
        rightButton.snp_makeConstraints { make in
            make.right.equalTo(-16)
            make.width.height.equalTo(44)
            make.centerY.equalTo(imgView)
        }
        
        lineView.snp_makeConstraints { make in
            make.left.equalTo(60)
            make.bottom.equalTo(-1)
            make.right.equalTo(0)
            make.height.equalTo(1)
        }
    }
}
