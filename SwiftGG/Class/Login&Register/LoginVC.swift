//
//  LoginVC.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/22.
//

import UIKit
import PKHUD

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
        label.text = "欢迎来到GG"
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
        btn.frame = CGRect(x: 16, y: 280, width: 20, height: 20)
        btn.setBackgroundImage(UIImage(named: "login_uncheck"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "login_check"), for: .selected)
        btn.addTarget(self, action: #selector(agreeBtnAction), for: .touchUpInside)
        return btn
    }()
    
    //我已阅读并同意文本
    fileprivate lazy var agreeLabel:UILabel = {
        
        let str = "我已阅读并同意《用户协议》及《隐私声明》"
        let label = UILabel(frame: CGRect(x: 40, y: 280, width: 300, height: 20))
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 13)
        
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
        btn.frame = CGRect(x: 16, y: 350, width: kScreenWidth - 32, height: 50)
        btn.backgroundColor = UIColor.blue
        btn.cornerWith(rectCorner: UIRectCorner.allCorners, radius: 22)
        btn.addTarget(self, action: #selector(sendCodeAction), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var pwdLoginBtn:UIButton = {
        let btn:UIButton = UIButton(type:.custom)
        btn.frame = CGRectMake(16, 420, 80, 22)
        btn.setTitle("密码登录", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(pwdLoginAction), for: .touchUpInside)
        self.view.addSubview(btn)
        return btn
    }()

    fileprivate lazy var regBtn:UIButton = {
        let btn:UIButton = UIButton(type:.custom)
        btn.frame = CGRectMake(kScreenWidth - 16 - 80, 420, 80, 22)
        btn.setTitle("注册账号", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.contentHorizontalAlignment = .right
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(regAction), for: .touchUpInside)
        self.view.addSubview(btn)
        return btn
    }()
    
    // MARK: - Life
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    func setupUI()
    {
        self.view.addSubview(logoImageView)
        self.view.addSubview(helloLabel)
        self.view.addSubview(phoneTextField)
        self.view.addSubview(agreeBtn)
        self.view.addSubview(agreeLabel)
        self.view.addSubview(codeBtn)
        self.view.addSubview(pwdLoginBtn)
        self.view.addSubview(regBtn)
        
    }
    
    // MARK: - Action
    @objc func agreeBtnAction() {
        agreeBtn.isSelected = !agreeBtn.isSelected
    }
    
    
    @objc func sendCodeAction() {
        
        let phoneNum:String = self.phoneTextField.textField.text!;
    
        let isValidPhone:Bool = GGRegular.isPhoneNumber(phoneNumber: phoneNum)
        if (!isValidPhone)
        {
            HUD.flash(.label("不是有效的电话号码"), delay: 1.5)
            return
        }
        
        if (!agreeBtn.isSelected)
        {
            HUD.flash(.label("请勾选用户协议及隐私声明"), delay: 1.5)
            return
        }
        
        //发送验证码
        let paramDict:[String:String] = ["mobile":phoneNum]
        NetworkTool.sendSmsCode(url: GG_LOGIN_BASE_URL + GG_LOGIN_SEND_CODE, parameters: paramDict) { data in
            
            HUD.flash(.labeledSuccess(title: "验证码发送成功", subtitle: ""), delay: 1)
            
        } failCallBack: { error in
            
            HUD.flash(.label(error["message"] as? String), delay: 1)
        };

    }
    
    @objc func pwdLoginAction()
    {
        print("密码登录")
    }
    
    @objc func regAction()
    {
        let regVC: RegisterVC = RegisterVC()
        self.navigationController?.pushViewController(regVC, animated: true)
    }
}
