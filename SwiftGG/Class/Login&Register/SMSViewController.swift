//
//  SMSViewController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/6.
//

import UIKit
import PKHUD

class SMSViewController: UIViewController {
    
    //类里面的变量定义，一般对象定义为可选类型，赋值为nil, 字符串属于结构体赋值空字符串，整形赋值0，浮点赋值0.0
    //手机号，从前面页面带过来的
    var phoneStr:String? = nil
    
    lazy var logImageView : UIImageView = {
        
        let imgView = UIImageView(frame: CGRect.zero)
        imgView.image = UIImage(named: "icon_login_back")
    
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(backAction))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tapGes)
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.text = "输入短信验证码"
        lbl.font = UIFont.systemFont(ofSize: 22)
        lbl.textAlignment = .left
        return lbl
    }()

    
    lazy var subTitleLable : YYLabel = {
        let lbl = YYLabel(frame: CGRect.zero)
        
        let str = "验证码已发送至 \(phoneStr ?? "")"
        let attrStr = NSMutableAttributedString(string: str)
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSRange(location: 8, length: 11))
        lbl.attributedText =  attrStr
    
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var smsView : SMSView = {
        let view = SMSView(frame: CGRect(x: 16, y: 200, width: kScreenWidth - 16 * 2, height: 100))
        
        view.delegate = self
        return view
    }()
    
    fileprivate lazy var reSendCodeBtn:UIButton = {
        let btn:UIButton = UIButton(type:.custom)
        btn.frame = CGRect(x: 16, y: 300, width: 80, height: 22)
        btn.setTitle("重现获取", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(resendAction), for: .touchUpInside)
        self.view.addSubview(btn)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        layoutViews()
    }
}


// MARK: - UI
extension SMSViewController
{
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(logImageView)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLable)
        view.addSubview(smsView)
        view.addSubview(reSendCodeBtn)
    }
}

// MARK: - layout
extension SMSViewController
{
    func layoutViews() {
        logImageView.snp_makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(36)
            make.width.height.equalTo(22)
        }

        titleLabel.snp_makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(logImageView.snp_bottom).offset(100)
            make.height.equalTo(30)
        }
        
        subTitleLable.snp_makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(titleLabel.snp_bottom).offset(10)
            make.height.equalTo(18)
        }
        
        smsView.snp_makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(subTitleLable.snp_bottom).offset(80)
            make.right.equalTo(-16)
            make.height.equalTo(100)
        }
        
        reSendCodeBtn.snp_makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(smsView.snp_bottom).offset(30)
            make.height.equalTo(18)
        }
    }
}

// MARK: - Action
extension SMSViewController
{
    @objc func backAction()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func resendAction() {
        print("resend code")
    }
}

// MARK: - SmscodeDelegate
extension SMSViewController : SmscodeDelegate
{
    func smsCodeViewInputFisish(smsview: SMSView, code: String) {
        print("code is :\(code)")
        
        //如果没有手机号码
        guard let phone = self.phoneStr else { return }
        
        //开始进行验证码登录
        let url = GG_HotTub_Code_Base + GG_SMS_LOGIN
        
        let paramDict:[String:String] = ["mobile":phone, "code": code]
        NetworkTool.requestSMSCodeLogin(url: url, params:paramDict, header: GG_NetWorkTool_Headers) { data in
            
            print("登录成功");
            HUD.flash(.success, delay: 1)
            
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
            
            //这里作为验证HandyJson ////////
            var modelArr1: [LoginModelNew] = []
            for dic:Dictionary in resultArr
            {
                if let model = LoginModelNew.deserialize(from: dic, designatedPath: nil){
                    modelArr1.append(model)
                }
            }
            print(modelArr1);
            
            ///////////////////////////
            
            let listVC =  LoginDomainListVC()
            listVC.dataArr = modelArr
            self.navigationController?.pushViewController(listVC, animated: true)
            
        } failCallBack: { messageInfo in
            
            let msg = messageInfo["message"] as? String
            HUD.flash(.label(msg))
        }
    }
}
