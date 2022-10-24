//
//  GGTextFiledView.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/23.
//

import UIKit
class GGTextFiledView : UIView {
    
    var limitNumber : Int
    lazy var textField:UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 44))
        tf.textAlignment = .left
        tf.keyboardType = .numberPad
        tf.borderStyle = .none
        tf.delegate  = self
        return tf
    }()
    
    lazy var lineView : UIView = {
        let line = UIView(frame: CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1))
        line.backgroundColor = UIColor.colorWithHex(hex: "#999999")
        return line
    }()
    
    override init(frame:CGRect) {
        self.limitNumber = 0
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
    
    
}


extension GGTextFiledView : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var str = textField.text
        if (self.limitNumber > 0 && self.limitNumber <= str!.count && string != "")
        {
            return false
        }
        
        return true
    }
}
