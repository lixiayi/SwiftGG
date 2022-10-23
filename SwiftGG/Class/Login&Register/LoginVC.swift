//
//  LoginVC.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/22.
//

import UIKit

class LoginVC: BaseVC {
    
    //logo
    fileprivate lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRectMake(16, 100, 44, 44))
        imageView.image = UIImage(named: "AppIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //欢迎语
    fileprivate lazy var helloLabel:UILabel = {
        
        let label = UILabel(frame: CGRect(x: 16, y: 144, width: 160, height: 44))
        label.text = "欢迎来到小慧"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()
    
    
    //手机号码输入框
    fileprivate lazy var phoneTextField: GGTextFiledView = {
        let phone = GGTextFiledView(frame: CGRect(x: 16, y: 200, width: kScreenWidth - 32, height: 44))
        phone.textField.placeholder = "请输入手机账号"
        phone.limitNumber = 11;
        return phone
    }()
    
    
    //我已阅读并同意选择圆框
    fileprivate lazy var agreeBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 16, y: 300, width: 20, height: 20)
        btn.setBackgroundImage(UIImage(named: "login_uncheck"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "login_check"), for: .selected)
        btn.addTarget(self, action: #selector(agreeBtnAction), for: .touchUpInside)
        return btn
    }()
    
    //我已阅读并同意文本
    fileprivate lazy var agreeLabel:UILabel = {
        
        let str = "我已阅读并同意《用户协议》及《隐私声明》"
        let label = UILabel(frame: CGRect(x: 40, y: 300, width: 300, height: 20))
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 12)
        
        //设置attribute
        let attrStr: NSMutableAttributedString = NSMutableAttributedString(string: str)
        attrStr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue], range: NSMakeRange(7, 6))
        attrStr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue], range: NSMakeRange(14, 6))
        label.attributedText = attrStr
        
        return label
    }()
    
    
    //手机登录时验证码按钮
    fileprivate lazy var codeBtn:UIButton = {
       
        let btn = UIButton(type: .custom)
        btn.setTitle("获取验证码", for: .normal)
        btn.frame = CGRect(x: 16, y: 400, width: kScreenWidth - 32, height: 50)
        btn.backgroundColor = UIColor.blue
        btn.cornerWith(rectCorner: UIRectCorner.allCorners, radius: 10)
        btn.addTarget(self, action: #selector(sendCodeAction), for: .touchUpInside)
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.setupUI()
    }
    
    
    func setupUI() {
        self.view.addSubview(logoImageView)
        self.view.addSubview(helloLabel)
        self.view.addSubview(phoneTextField)
        self.view.addSubview(agreeBtn)
        self.view.addSubview(agreeLabel)
        self.view.addSubview(codeBtn)
        
    }
    
    // MARK: - Action
    @objc func agreeBtnAction() {
        agreeBtn.isSelected = !agreeBtn.isSelected
    }
    
    
    @objc func sendCodeAction() {
        
        let phoneNum:String = self.phoneTextField.textField.text!;
    
        do
        {
            let pattern = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
            let reg : NSRegularExpression = try NSRegularExpression(pattern: pattern)
            let result : NSTextCheckingResult? = reg.firstMatch(in: phoneNum, range: NSMakeRange(0, phoneNum.count))
            
            if result == nil
            {
                print("不是有效的电话号码")
            }
        }
        catch {
            print("验证手机号码错误")
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
