//
//  LoginVC.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/22.
//

import UIKit
import PKHUD
//import YYKit  --- 第三方库头文件定义 或 在Header.h统一定义

class LoginVC: BaseVC {
    
    //是否验证码登录，默认是
    var isCodeLogin : Bool = true
    
    //logo
    fileprivate lazy var logoImageView: UIImageView = {
        
        let imageView = UIImageView(frame: CGRect(x: 16, y: 100, width: 44, height: 44))
        imageView.image = UIImage(named: "AppIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //欢迎语
    fileprivate lazy var helloLabel:UILabel = {
        
        let label = UILabel(frame: CGRect(x: 16, y: 144, width: 160, height: 44))
        label.text = "欢迎来到 GG"
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
        phone.textField.isSecureTextEntry = false
        return phone
    }()
    
    //密码登录时密码输入框
    fileprivate lazy var pwdTextField: GGTextFiledView = {
        let pwdTf = GGTextFiledView(frame: CGRect(x: 16, y: 250, width: kScreenWidth - 32, height: 44))
        pwdTf.textField.placeholder = "请输入密码"
        pwdTf.rightBtnBackgroudImageName = "icon_login_pwd_close"
        pwdTf.rightBtnBackgroudSelectImageName = "icon_login_pwd_open"
        pwdTf.showRightBtn = true
        return pwdTf
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
    fileprivate lazy var agreeLabel:YYLabel = {
        
        let str = "我已阅读并同意《用户协议》及《隐私声明》"
        let label = YYLabel(frame: CGRect(x: 40, y: 280, width: 300, height: 20))
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
        
        btn.frame = CGRect(x: 16, y: 420, width: 120, height: 22)
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
        btn.frame =  CGRect(x: kScreenWidth - 16 - 80, y: 420, width: 80, height: 22)
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
        self.view.addSubview(pwdTextField)
        //默认是验证码登录，密码输入框隐藏
        pwdTextField.isHidden = true
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
        if (phoneNum.count == 0)
        {
            HUD.flash(.label("请输入手机账号"))
            return
        }
            
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
        
        if (self.isCodeLogin)
        {
            //发送验证码
            let paramDict:[String:String] = ["mobile":phoneNum]
            
            NetworkTool.sendSmsCode(url: GG_HotTub_Code_Base + GG_LOGIN_SEND_CODE, parameters: paramDict,header:GG_NetWorkTool_Headers) { data in
                
                HUD.flash(.labeledSuccess(title: "验证码发送成功", subtitle: ""), delay: 1)
                
                //TODO::进入输入验证码页面
                let smsVC = SMSViewController()
                smsVC.phoneStr = self.phoneTextField.textField.text
                self.navigationController?.pushViewController(smsVC, animated: true)
                
            } failCallBack: { error in
                
                HUD.flash(.label(error["message"] as? String), delay: 1)
            };
        }
        else
        {
            //密码登录
            if (self.pwdTextField.textField.text?.count == 0)
            {
                HUD.flash(.label("请输入密码"))
                return
            }
            
            self.requestPwdLogin()
        }

    }
    
    @objc func pwdLoginAction()
    {
        isCodeLogin = !isCodeLogin
        if (isCodeLogin)
        {
            pwdLoginBtn.setTitle("密码登录", for: .normal)
            pwdTextField.isHidden = true
            codeBtn.setTitle("获取验证码", for: .normal)
            
            //下面的控件都上移50
            UIView.animate(withDuration: 0.25) {
                self.agreeBtn.mj_y -= 50
                self.agreeLabel.mj_y -= 50
                self.codeBtn.mj_y -= 50
                self.pwdLoginBtn.mj_y -= 50
                self.regBtn.mj_y -= 50;
            }
        }
        else
        {
            pwdLoginBtn.setTitle("手机验证码登录", for: .normal)
            pwdTextField.isHidden = false
            codeBtn.setTitle("登录", for: .normal)
            
            UIView.animate(withDuration: 0.25) {
                
                //显示密码输入框
                self.pwdTextField.isHidden = false
                
                //下面的控件都下移50
                self.agreeBtn.mj_y += 50
                self.agreeLabel.mj_y += 50
                self.codeBtn.mj_y += 50
                self.pwdLoginBtn.mj_y += 50
                self.regBtn.mj_y += 50;
            }
        }
    }
    
    @objc func regAction()
    {
        let regVC: RegisterVC = RegisterVC()
        self.navigationController?.pushViewController(regVC, animated: true)
    }
    
    func requestPwdLogin() {
        
        //1.获取公钥接口
        let ud = UserDefaults.standard
        let publicKey:String? = ud.string(forKey: kLoginPublicKey)
        if (publicKey == nil || publicKey?.count == 0)
        {
            let url = GG_HotTub_Code_Base + GG_HotTub_Code_GetPubkey
            NetworkTool.getLoginPublicKey(url: url, parameter: nil) { data in
                
                //获取data
                let dic: NSDictionary = ((data as? NSDictionary)!)
                guard let pubKey = dic["key"] else { return  }
                
                //保存公钥
                ud.setValue(pubKey, forKey: kLoginPublicKey)
                
                //开始请求
                self.requestPwdLoginWithPublicKey(key: pubKey as! String)
                
                
            } failCallBack: { messageInfo in

            }
        }
        else
        {
            //2.请求密码登录接口
            self.requestPwdLoginWithPublicKey(key: publicKey!)
        }
    }
    
    func requestPwdLoginWithPublicKey(key:String)  {
        
        //1.RAS加密密码
        let passwordEncrypt:String? = RSA.encryptString(pwdTextField.textField.text, publicKey: key)
        
        let paras: Dictionary<String ,String> = ["account" : phoneTextField.textField.text!, "password" : passwordEncrypt!]
        
        let url = GG_HotTub_Code_Base + GG_HotTub_Code_PwdLogin
        NetworkTool.requestPasswordLogin(url:url , parameter: paras) { data in
            //一步步拆解，否则报类型推断错误
            //1.将data转成字典
            guard let resultDict = data as? [String : AnyObject] else { return }
            
            //2.根据data的key获取数组
            guard let resultArr = resultDict["data"] as? [[String : AnyObject]] else { return }
           
            var modelArr: [LoginModel] = []
            for dic:Dictionary in resultArr
            {
                let model = LoginModel(dict: dic)
                modelArr.append(model)
            }
            
            let listVC =  LoginDomainListVC()
            listVC.dataArr = modelArr
            self.navigationController?.pushViewController(listVC, animated: true)
            
            //获取下面这么写都可
//            guard let dic : Dictionary = data as? Dictionary<String, NSObject> else { return }
//            guard let arr : Array<Dictionary> = dic["data"] as? Array<Dictionary<String, NSObject>> else { return }
//
//            var modelArr: [LoginModel] = []
//            for dic:Dictionary in arr
//            {
//                let model = LoginModel(dict: dic)
//                modelArr.append(model)
//            }
            
            
        } failCallBack: { messageInfo in

        }
    }
}
