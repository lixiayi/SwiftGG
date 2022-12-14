//
//  RegisterVC.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/22.
//

import UIKit
import PKHUD

let kTfHeight : CGFloat = 44

class RegisterVC: BaseVC,GGTextFieldDelegate {

    // MARK: - Life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.setupUI()
    }
    
    
    func setupUI() {
        self.view.addSubview(backBtn)
        self.view.addSubview(titleLabl)
        self.view.addSubview(domainTextField)
        self.view.addSubview(nameTextField)
        self.view.addSubview(phoneTextField)
        self.view.addSubview(codeTextField)
        self.view.addSubview(pwdTextField)
        self.view.addSubview(agreeBtn)
        self.view.addSubview(agreeLabel)
        self.view.addSubview(regBtn)
        self.view.addSubview(haveAccountBtn)
    }
    
    // MARK: - Lazy
    fileprivate lazy var backBtn:UIButton = {
        let btn:UIButton = UIButton(type:.custom)
        btn.frame = CGRect(x: 16, y: 30, width: 22, height: 22)
        btn.setBackgroundImage(UIImage(named: "icon_login_back"), for: .normal)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        return btn
    }()
    
    fileprivate lazy var titleLabl: UILabel = {
        
        let label = UILabel(frame: CGRect(x: 16, y: 70, width: 120, height: 30))
        label.text = "欢迎注册 小慧"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left

        return label
    }()
    
    fileprivate lazy var domainTextField:GGTextFiledView = {
        
        let domainTf : GGTextFiledView = GGTextFiledView (frame: CGRect(x: 16, y: 100, width: kScreenWidth - 32, height: kTfHeight))
        domainTf.setPlaceHolder(placeHolder: "请输入GG域名")
        domainTf.rightBtnBackgroudImageName = "reg_help"
        domainTf.rightBtnBackgroudSelectImageName = ""
        domainTf.btnTag = 1000;
        
        domainTf.showRightBtn = true
        domainTf.delegate = self
       
        
        return domainTf
    }()
    
    fileprivate lazy var nameTextField:GGTextFiledView = {
        let nameTf : GGTextFiledView = GGTextFiledView (frame: CGRect(x: 16, y: 100 + 50, width: kScreenWidth - 32, height: kTfHeight))
        nameTf.setPlaceHolder(placeHolder: "请输入姓名")
        return nameTf
    }()
    
    fileprivate lazy var phoneTextField:GGTextFiledView = {
        
        
        let phoneTf : GGTextFiledView = GGTextFiledView (frame:CGRect(x: 16, y: 100 + 50 * 2, width: kScreenWidth - 32, height: kTfHeight))
        phoneTf.setPlaceHolder(placeHolder: "请输入手机号")
        return phoneTf
    }()
    
    fileprivate lazy var codeTextField:GGTextFiledView = {
        
        
        let codeTf : GGTextFiledView = GGTextFiledView (frame: CGRect(x: 16, y: 100 + 50 * 3, width: kScreenWidth - 32, height: kTfHeight))
        codeTf.setPlaceHolder(placeHolder: "请输入验证码")
        return codeTf
    }()
    
    fileprivate lazy var pwdTextField:GGTextFiledView = {
        
        let pwdTf : GGTextFiledView = GGTextFiledView (frame: CGRect(x: 16, y: 100 + 50 * 4, width: kScreenWidth - 32, height: kTfHeight))
        pwdTf.setPlaceHolder(placeHolder: "请输入密码")
        pwdTf.rightBtnBackgroudImageName = "icon_login_pwd_close"
        pwdTf.rightBtnBackgroudSelectImageName = "icon_login_pwd_open"
        pwdTf.btnTag = 1001
        pwdTf.showRightBtn = true
        pwdTf.delegate = self
        
        self.view.addSubview(pwdTf)
        return pwdTf
    }()
    
    //我已阅读并同意选择圆框
    fileprivate lazy var agreeBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 16, y: 100 + 50 * 5 + 20, width: 20, height: 20)
        btn.setBackgroundImage(UIImage(named: "login_uncheck"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "login_check"), for: .selected)
        btn.addTarget(self, action: #selector(agreeBtnAction), for: .touchUpInside)
        return btn
    }()
    
    //我已阅读并同意文本
    fileprivate lazy var agreeLabel:YYLabel = {
        
        let str = "我已阅读并同意《用户协议》及《隐私声明》"
        let label = YYLabel(frame: CGRect(x: 40, y: 100 + 50 * 5 + 20, width: 300, height: 20))
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 13)
        
        //设置attribute
        var attrStr: NSMutableAttributedString = NSMutableAttributedString(string: str)
        
        
        // 包含点击事件，一定要是YYLabel
        attrStr.setTextHighlight(NSRange(location: 7,length: 6), color: UIColor.blue, backgroundColor: UIColor.clear) { (view : UIView, str : NSAttributedString, range : NSRange , rect : CGRect) in
            
            let subStr = str.attributedSubstring(from: range)
            //点击进入用户协议
            let webVC = GGWebViewController()
            webVC.doRequest(myUrl: GG_UserProtcolUrl)
            self.navigationController?.pushViewController(webVC, animated: true)
        }

        attrStr.setTextHighlight(NSRange(location: 14,length: 6), color: UIColor.blue, backgroundColor: UIColor.clear) { (view : UIView, str : NSAttributedString, range : NSRange , rect : CGRect) in
            let subStr = str.attributedSubstring(from: range)
            //点击进入隐私声明
            HUD.flash(.label(subStr.string))
            let webVC = GGWebViewController()
            webVC.doRequest(myUrl: GG_PrivacyPolicyUrl)
            self.navigationController?.pushViewController(webVC, animated: true)
        }


        label.attributedText = attrStr
        
        return label
    }()
    
    
    //注册按钮
    fileprivate lazy var regBtn:UIButton = {
       
        let btn = UIButton(type: .custom)
        btn.setTitle("注册", for: .normal)
        btn.frame = CGRect(x: 16, y: 100 + 50 * 6 + 20, width: kScreenWidth - 32, height: 50)
        btn.backgroundColor = UIColor.blue
        btn.cornerWith(rectCorner: UIRectCorner.allCorners, radius: 22)
        btn.addTarget(self, action: #selector(regAction), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var haveAccountBtn:UIButton = {
        let btn:UIButton = UIButton(type:.custom)
        btn.frame = CGRect(x: 16, y: 100 + 50 * 7 + 30, width: 60, height: 22)
        btn.setTitle("已有账号", for: .normal)
        btn.titleLabel?.textAlignment = .left
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(haveAccountBtnAction), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Actrion
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func agreeBtnAction()
    {
        agreeBtn.isSelected = !agreeBtn.isSelected
    }
    
    @objc func regAction() {
        
        print(regAction)
    }
    
    @objc func haveAccountBtnAction()
    {
        self.backAction()
    }
    
    // MARK: - GGTextFieldViewDelegate
    func doRightBtnAction(sender:UIButton) {
        if (sender.tag == 1000)
        {
            let alertView = UIAlertController(title: "提示", message: "\"小慧\"域名即公司简称，请联系所在公司负责人获取", preferredStyle: .alert)
            let action = UIAlertAction(title: "我知道了", style: .default)
            alertView.addAction(action)
            self.present(alertView, animated: true)
        }
    }
    
}
