//
//  LoginViewController.swift
//  SwiftGG
//
//  Created by stoicer on 2021/1/9.
//

import UIKit

enum LoginType {
    case loginTypeCode
    case loginTypePwd
}

class LoginViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var loginType:LoginType = .loginTypeCode
    var recommArr:[LoginRecomModel] = [];
    @IBOutlet weak var topBGImageView: UIImageView!
    @IBOutlet weak var loginBGView: UIView!
    @IBOutlet weak var recommBGView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var moreBGView: UIView!
    /** 登录按钮*/
    @IBOutlet weak var loginBtn: UIButton!
    /** 发送验证码按钮*/
    @IBOutlet weak var codeBtn: UIButton!
    /** 验证码登录或密码登录按钮*/
    @IBOutlet weak var loginSwitchBtn: UIButton!
    /**我已经阅读并同意 */
    @IBOutlet weak var checkUserAgentBtn: UIButton!
    /** 用户协议以及隐私声明按钮 */
    @IBOutlet weak var userAgentBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
        self.setCorner()
        
       //请求域名数据
        self.requestDomainData()
    }
    
    
    ///发送验证码
    @IBAction func codeAction(_ sender: Any) {
        
    }
    
    ///选中我已经阅读
    @IBAction func checkUserAgentAction(_ sender: Any) {
        self.checkUserAgentBtn.isSelected = !self.checkUserAgentBtn.isSelected
        if checkUserAgentBtn.isSelected {
            checkUserAgentBtn.setImage(UIImage(named: "login_check"), for: .selected)
        }
        else
        {   
            checkUserAgentBtn.setImage(UIImage(named: "login_uncheck"), for: .normal)
        }
    }
    /// 用户协议以及隐私声明
    @IBAction func userAgentAction(_ sender: Any) {
    }
    
    
    ///登录
    @IBAction func loginAction(_ sender: Any) {
        
    }
    
    ///登录切换
    @IBAction func loginSwitchAction(_ sender: Any) {
     
        if loginType == .loginTypeCode {
            loginType = .loginTypePwd
            self.codeBtn.isHidden = true
            self.loginSwitchBtn.setTitle("密码登录", for: .normal)
        }
        else
        {
            loginType = .loginTypeCode
            self.codeBtn.isHidden = false
            self.loginSwitchBtn.setTitle("验证码登录", for: .normal)
        }
        
    }
    @IBAction func moreAction(_ sender: Any) {
        
        let vc = ViewController();
        self.present(vc, animated: true)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoginRecommCollCell", for: indexPath) as! LoginRecommCollCell
        
        let model: LoginRecomModel = recommArr[indexPath.row]
        collCell.model = model
        return collCell
    }
    
}

///扩展
extension LoginViewController
{
    func setCorner() {
        self.loginBGView.layer.cornerRadius = 10
        self.moreBGView.cornerWith(rectCorner: [.topLeft, .bottomLeft], radius: 10)
        self.codeBtn.layer.cornerRadius = 14
        self.loginBtn.layer.cornerRadius = 22
    }
    
    func setupUI() {
        self.collectionView.register(UINib.init(nibName: "LoginRecommCollCell", bundle: nil), forCellWithReuseIdentifier: "LoginRecommCollCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    //MARK:请求数据
    func requestDomainData()  {
        let urlStr = BASE_URL + kWisdom_GetRecommend
        NetworkTool.requestRecommendDomain(url: urlStr, param: nil) { [weak self] (data) in
            self?.recommArr = data as! [LoginRecomModel]
            
            if ((self?.recommArr.count)! > 4)
            {
                let subFour = [] + (self?.recommArr.prefix(4))!
                self?.recommArr = subFour
            }
            
            self?.collectionView.reloadData()
        } failCallBack: { (error) in
            
        };

    }
}

