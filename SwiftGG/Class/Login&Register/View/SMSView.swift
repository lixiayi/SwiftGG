//
//  SMSView.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/6.
//

import UIKit

//每个item的间距
let kItemMargin:CGFloat = 10

//多少个Item
let kItemCount:Int = 6

//每个item的高度
let kItemHeight:CGFloat = 80

//每个Item的圆角值
let kItemCornerRaduis : CGFloat = 5.0

//每个item的宽度
let kItemBorderWithd : CGFloat = 1.0

//定义代理
protocol SmscodeDelegate {
    func smsCodeViewInputFisish(smsview:SMSView, code:String)
}

class SMSView: UIView {
    
    var delegate : SmscodeDelegate?
    
    var tfArr:[UITextField] = Array()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self .setupViews()
        
        //让用户不能点击
        self.isUserInteractionEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTexeField(tag : Int) {
        
        let width = (self.bounds.size.width - (CGFloat)((CGFloat)(kItemCount - 1) * kItemMargin)) / 6
        let orgintX = (width + CGFloat(kItemMargin)) * CGFloat(tag - 1)
        let tf = UITextField(frame: CGRect(x: orgintX, y: 0, width: width, height: kItemHeight))
        
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.layer.cornerRadius = kItemCornerRaduis
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.font = UIFont.systemFont(ofSize: 22)
        tf.keyboardType = .numberPad
        tf.delegate = self
        tf.tag = tag
        
        tfArr.append(tf)
        addSubview(tf)
    }
    
    func setupViews() {
        //添加6个输入框
        var i=0
        while i < kItemCount {
            i+=1
            self.createTexeField(tag: i)
        }
        
        //让第一个输入框获取焦点
        tfArr.first?.becomeFirstResponder()
    }
    
    
  
    
}

// MARK: - UITextFieldDelegate

extension SMSView : UITextFieldDelegate
{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !textField.hasText
        {
            let index = textField.tag
            
            textField.resignFirstResponder()
            
            if (index == tfArr.count)
            {
                tfArr[index-1].text = string
                //拼接
                var code = ""
                for tv in tfArr
                {
                    code += tv.text ?? ""
                }
                
                //传给代理
                
                delegate?.smsCodeViewInputFisish(smsview: self, code: code)
            }
            
            tfArr[index-1].text = string
            
            if index < tfArr.count
            {
                tfArr[index].becomeFirstResponder()
            }
        }
        
        return false
    }
}
