//
//  NetworkTool.swift
//  SwiftGG
//
//  Created by stoicer on 2021/1/10.
//

import Foundation
import Alamofire
import SwiftyJSON
import HandyJSON


/** 基础URL */
let BASE_URL = "https://wisdomcloud.pispower.com"
/** 推荐域名URL */
let kWisdom_GetRecommend = "/wisdom/api/chameleonChatserver/queryForRecommend"



// MARK: - 登录相关
//登录相关的BaseUrl
let GG_LOGIN_BASE_URL = "https://chatoc.onecloud.cn"

let GG_HotTub_Code_Base = "https://appcc.onecloud.cn"

//发送验证码
let GG_LOGIN_SEND_CODE = "/business/sms/send?"

///用户协议
let GG_UserProtcolUrl = "https://hc.pispower.com/h5/agreement/userAgreement.html?disable_more=true"

///隐私政策声明
let GG_PrivacyPolicyUrl = "https://hc.pispower.com/h5/agreement/privacyPolicy.html?disable_more=true"

/// 获取加密公钥
let GG_HotTub_Code_GetPubkey = "/hottub/chatserver/user/uso/getpubkey?"

/// 账号密码登录
let GG_HotTub_Code_PwdLogin  = "/hottub/chatserver/user/uso/login1?"


///智慧云boss
let GG_WisdomBossUrl  =  "https://wisdomboss.onecloud.cn"

/// 大路由设计-获取企业域名域名配置信息
let GG_HotTub_Code_CompanyInfoByRouter = "/chatserver/component?"

//login2
let GG_Code_LinkLogin  = "/business/user/login2?"


//headers
let GG_NetWorkTool_Headers = ["Oc_Platform_Type" : "2",
                              "Oc_Platform_SysVersion": String(UIDevice.systemVersion()),
                              "Oc_Platform_AppVersion" : Bundle.main.infoDictionary?["CFBundleShortVersionString"],
                              "Oc_Platform_Token" : "",
                              "Oc_Chatserver_MinVersion" : "3.0",
                              "Oc_Chatserver_Id" : "2"] as! [String : String]


class NetworkTool {
    
    /** 成功回调 */
    typealias successCallBack = ((_ data:Any)->())?

    /** 失败回调 */
    typealias failureCallBack = ((_ messageInfo:Dictionary<String,AnyObject>)->())?
    
    static func requestRecommendDomain(url:String, param:Dictionary<String, String>?, succCallBack:successCallBack, failCallBack: failureCallBack)
    {
        Alamofire.request(url).responseJSON
        { data in
            guard data.result.isSuccess else {return}
            if let value = data.result.value {
                let json = JSON(value);
                let status = json["resCode"]
                if 200 == status
                {
                
                    var dataArr:[LoginRecomModel] = []
                    if let message = json["response"].array
                    {
                        for item in message
                        {
                            let submodel = LoginRecomModel.deserialize(from: item.dictionary)
                            dataArr.append(submodel!)
                        }
                    }
                    
                    if dataArr.count > 0 {
                        succCallBack?(dataArr)
                    }

                }
                else
                {
                    failCallBack!(value as! Dictionary<String, AnyObject>)
                }
            }
        }
    }
    
    //请求发送验证码
    static func sendSmsCode(url:String, parameters:Dictionary<String,String>?, succCallBack:successCallBack,failCallBack:failureCallBack)
    {
        Alamofire.request(url,parameters: parameters).responseJSON { data in
            guard data.result.isSuccess else { return }
            if let value = data.result.value {
                let json = JSON(value);
                let status = json["code"]
                if 0 == status
                {
                    succCallBack?(value as? NSDictionary as Any)
                    
                }
                else
                {
                    failCallBack!(value as! Dictionary<String, AnyObject>)
                }
            }
        }
    }
    
    static func getLoginPublicKey(url:String, parameter:Dictionary<String, String>?,
        succCallBack:successCallBack,failCallBack:failureCallBack)
    {
        Alamofire.request(url, parameters:parameter).responseJSON { data in
            guard data.result.isSuccess else { return }
            if let value = data.result.value {
                let json = JSON(value);
                let status = json["code"]
                if 0 == status
                {
                    succCallBack?(value as? NSDictionary as Any)
                    
                }
                else
                {
                    failCallBack!(value as! Dictionary<String, AnyObject>)
                }
            }
        }
    }
    
    static func requestPasswordLogin(url:String, parameter:Dictionary<String, String>?,
        succCallBack:successCallBack,failCallBack:failureCallBack)
    {
        Alamofire.request(url, parameters:parameter).responseJSON { data in
            guard data.result.isSuccess else { return }
            if let value = data.result.value {
                let json = JSON(value);
                let status = json["code"]
                if 0 == status
                {
                    succCallBack?(value as! Dictionary<String, AnyObject>)
                    
                }
                else
                {
                    failCallBack!(value as! Dictionary<String, AnyObject>)
                }
            }
        }
    }
    
    static func requestGruopInfo(url:String, parameter:Dictionary<String, String>?,
        succCallBack:successCallBack,failCallBack:failureCallBack)
    {
        Alamofire.request(url, parameters:parameter).responseJSON { data in
            guard data.result.isSuccess else { return }
            if let value = data.result.value {
                let json = JSON(value);
                let status = json["code"]
                if 200 == status
                {
                    succCallBack?(value as! Dictionary<String, AnyObject>)
                    
                }
                else
                {
                    failCallBack!(value as! Dictionary<String, AnyObject>)
                }
            }
        }
    }
    
    static func requestLastLoginWithHeader(url:String ,parameter:Dictionary<String, Any>?,
        header:[String : String],succCallBack:successCallBack,failCallBack:failureCallBack)
    {
        Alamofire.request(url,parameters: parameter,headers: header).responseJSON { data in
            guard data.result.isSuccess else {return}
            if let value = data.result.value {
                let json = JSON(value);
                let status = json["code"]
                if 0 == status
                {
                    succCallBack?(value as! Dictionary<String, AnyObject>)
                    
                }
                else
                {
                    failCallBack!(value as! Dictionary<String, AnyObject>)
                }
            }
        }
    }
    
    

    
}
