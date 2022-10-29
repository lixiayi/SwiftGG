//
//  RegisterVC.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/22.
//

import UIKit
import PKHUD

let kTfHeight : CGFloat = 44

class RegisterVC: BaseVC {

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
        btn.frame = CGRectMake(16, 30, 22, 22)
        btn.setBackgroundImage(UIImage(named: "icon_login_back"), for: .normal)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        return btn
    }()
    
    fileprivate lazy var titleLabl: UILabel = {
        let label = UILabel(frame: CGRectMake(16, 70, 120, 30))
        label.text = "欢迎注册 小慧"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left

        return label
    }()
    
    fileprivate lazy var domainTextField:GGTextFiledView = {
        let domainTf : GGTextFiledView = GGTextFiledView (frame: CGRectMake(16, 100, kScreenWidth - 32, kTfHeight))
        domainTf.setPlaceHolder(placeHolder: "请输入小慧域名")
        return domainTf
    }()
    
    fileprivate lazy var nameTextField:GGTextFiledView = {
        let nameTf : GGTextFiledView = GGTextFiledView (frame: CGRectMake(16, 100 + 50, kScreenWidth - 32, kTfHeight))
        nameTf.setPlaceHolder(placeHolder: "请输入姓名")
        return nameTf
    }()
    
    fileprivate lazy var phoneTextField:GGTextFiledView = {
        let phoneTf : GGTextFiledView = GGTextFiledView (frame: CGRectMake(16, 100 + 50 * 2, kScreenWidth - 32, kTfHeight))
        phoneTf.setPlaceHolder(placeHolder: "请输入手机号")
        return phoneTf
    }()
    
    fileprivate lazy var codeTextField:GGTextFiledView = {
        let codeTf : GGTextFiledView = GGTextFiledView (frame: CGRectMake(16, 100 + 50 * 3, kScreenWidth - 32, kTfHeight))
        codeTf.setPlaceHolder(placeHolder: "请输入验证码")
        return codeTf
    }()
    
    fileprivate lazy var pwdTextField:GGTextFiledView = {
        let pwdTf : GGTextFiledView = GGTextFiledView (frame: CGRectMake(16, 100 + 50 * 4, kScreenWidth - 32, kTfHeight))
        pwdTf.setPlaceHolder(placeHolder: "请输入密码")
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
}
