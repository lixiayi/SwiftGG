//
//  LoginRecommCollCell.swift
//  SwiftGG
//
//  Created by stoicer on 2021/1/10.
//

import UIKit
import Kingfisher
class LoginRecommCollCell: UICollectionViewCell {
    
    var model : LoginRecomModel = LoginRecomModel()
    {
        didSet
        {
            
            let imageUrl :String? = model.recommend_image;
            print("imageUrl:\(String(describing: imageUrl))")
            if imageUrl != "null"
            {
                self.recommendImageBtn.kf.setImage(with: URL(string: imageUrl!), for: .normal)
            }
            else
            {
                self.recommendImageBtn.setImage(UIImage(named: "login_domain_default"), for: .normal)
            }
        }

    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBOutlet weak var recommendImageBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func recommendImageBtnAction(_ sender: Any) {
        
    }
}
