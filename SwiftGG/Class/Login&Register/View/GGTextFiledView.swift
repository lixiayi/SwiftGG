//
//  GGTextFiledView.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/23.
//

import UIKit

fileprivate let kHeight:CGFloat = 50
fileprivate let kRightBtnHW:CGFloat = 20

protocol GGTextFieldDelegate : AnyObject {
    func doRightBtnAction(sender:UIButton)
}

class GGTextFiledView : UIView{
    //现在输入框输入的长度
    var limitNumber : Int
    
    // delegate
    weak var delegate : GGTextFieldDelegate?
    
    //是否显示
    var isShow :Bool
    
    //是否显示右侧按钮
    var showRightBtn : Bool {
        get {
            return isShow
        }
        
        set(newValue) {
            isShow = newValue
            if (isShow)
            {
                self.addSubview(rightBtn)
            }
        }
    }
    
    //右侧按钮tag
    var btnTag : Int
    
    //右侧按钮的名称 - 默认状态
    var rightBtnBackgroudImageName : String
    var rightBtnBackgroudSelectImageName : String
    
    
    lazy var textField:UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: kHeight))
        tf.textAlignment = .left
        tf.keyboardType = .numberPad
        tf.borderStyle = .none
        tf.delegate  = self
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var lineView : UIView = {
        let line = UIView(frame: CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1))
        line.backgroundColor = UIColor.colorWithHex(hex: "#999999")
        return line
    }()
    
    lazy var rightBtn : UIButton = {
        let btn = UIButton(frame: CGRect(x: (CGFloat)(kScreenWidth - 32 - kRightBtnHW), y: (CGFloat)(kRightBtnHW * 0.5), width: 20, height: 20))
        if (self.showRightBtn)
        {
            btn.setImage(UIImage(named: rightBtnBackgroudImageName), for: .normal)
            btn.setImage(UIImage(named: rightBtnBackgroudSelectImageName), for: .selected)
            btn.tag = self.btnTag
        }
        btn.addTarget(self, action: #selector(rightBtnAction), for: .touchUpInside)
        return btn
    }()
    
    @objc func rightBtnAction(sender:UIButton)
    {
        sender.isSelected = !sender.isSelected
        self.textField.isSecureTextEntry = !sender.isSelected
        self.delegate?.doRightBtnAction(sender: sender)
    }
    
    
    override init(frame:CGRect) {
        self.limitNumber = 0
        self.isShow = false
        self.rightBtnBackgroudImageName = ""
        self.rightBtnBackgroudSelectImageName = ""
        self.btnTag = 0
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(textField)
        self.addSubview(lineView)
    }
    
    public func setPlaceHolder(placeHolder:String)
    {
        self.textField.placeholder = placeHolder
    }
}


extension GGTextFiledView : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let str = textField.text
        if (self.limitNumber > 0 && self.limitNumber <= str!.count && string != "")
        {
            return false
        }
        
        return true
    }
}
