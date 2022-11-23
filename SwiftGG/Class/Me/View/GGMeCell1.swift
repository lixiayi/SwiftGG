//
//  GGMeCell1.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/23.
//

import UIKit


let GGMeCell1ID = "GGMeCell1ID"

class GGMeCell1: UITableViewCell {

    lazy var iconImageView : UIImageView = {
        
        let icon = UIImageView(image: UIImage(named: "default"))
        icon.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    
    lazy var titleLabel : UILabel =
    {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
        
    }()
    
    lazy var rightBtn : UIButton =
    {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "default"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
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
        
        self.selectionStyle = .none
        self.setupView()
        self.layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI
extension GGMeCell1
{
    func setupView()  {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightBtn)
    }
    
    func layoutViews() {
        iconImageView.snp_makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalTo(0);
            make.width.height.equalTo(44)
        }
        
        titleLabel.snp_makeConstraints { make in
            make.left.equalTo(iconImageView.snp_right).offset(16)
            make.centerY.equalTo(iconImageView)
            make.right.equalTo(rightBtn.left).offset(-16)
        }
        
        rightBtn.snp_makeConstraints { make in
            make.right.equalTo(-16);
            make.width.height.equalTo(44)
            make.centerY.equalTo(iconImageView)
        }
    }
}
