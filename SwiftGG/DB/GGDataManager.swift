//
//  GGDataManager.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/2.
//

import Foundation



class GGDataManager
{

    class func saveUserInfo(dic: [String: AnyObject])
    {
        //token
        let token = dic["token"]
        let userName = dic["nick_name"]
        let avatarUrl = dic["avatar_url"]
        let name = dic["name"]
        let imState = dic["jg_im_enable"]
        let takenSystemDesk = dic["taken_sys_desktop"] as? Bool
        let jgImUserName = dic["jg_im_uname"]
        let jgImPwd = dic["jg_im_pwd"]
        let isVip = dic["grade"]
        let nickNameList = dic["kNickName_list"]
        let templateInfo = dic["template_info"]
        let userSysInfo =  dic["sys_props"]
        let companyInfo = dic["kBranchCompaniesInfo"]
        let authList = dic["auth_list"]
        
        GGUserDefault.set(token, forKey: kGGToken)
        GGUserDefault.set(userName, forKey: kGGUserName)
        GGUserDefault.set(avatarUrl, forKey: kGGAvatar)
        GGUserDefault.set(name, forKey: kGGAvatar)
        GGUserDefault.set(imState, forKey: kImState)
        GGUserDefault.set(takenSystemDesk, forKey: kImState)
        GGUserDefault.set(jgImUserName, forKey: kIMAccount)
        GGUserDefault.set(jgImPwd, forKey: kIMPwd)
        GGUserDefault.set(isVip, forKey: kIsVIP)
        GGUserDefault.set(nickNameList, forKey: kNickName_list)
        GGUserDefault.set(templateInfo, forKey: kTemplate_info)
        GGUserDefault.set(userSysInfo, forKey: kUserSysInfo)
        GGUserDefault.set(companyInfo, forKey: kBranchCompaniesInfo)
        GGUserDefault.set(authList, forKey: kAuth_list)
    }
}

extension GGDataManager
{
    
    class func saveDomainInfo(_ dic : [String : NSObject]) {
        GGUserDefault.set(dic["openfire_bosh"], forKey: "openfire_bosh")
        GGUserDefault.set(dic["calling_api"], forKey: "calling_api")
        GGUserDefault.set(dic["chath5_api"], forKey: "chath5_api")
        GGUserDefault.set(dic["space_info"], forKey: "space_api")
        GGUserDefault.set(dic["meeting_api"], forKey: "meeting_api")
        GGUserDefault.set(dic["sensitive_api"], forKey: "sensitive_api")
        GGUserDefault.set(dic["chatserver_id"], forKey: "chatserver_id")
        GGUserDefault.set(dic["QRUrl"], forKey: "QRUrl")
        GGUserDefault.set(dic["openfire_xmpp_host"], forKey: "openfire_xmpp_host")
        GGUserDefault.set(dic["officeagent_api"], forKey: "officeagent_api")
        GGUserDefault.set(dic["wallet_api"], forKey: "wallet_api")
        GGUserDefault.set(dic["officechat_api"], forKey: "officechat_api")
        GGUserDefault.set(dic["teamwork"], forKey: "teamwork")
        GGUserDefault.set(dic["company_name"], forKey: "company_name")
        GGUserDefault.set(dic["wisdom"], forKey: "wisdom")
        GGUserDefault.set(dic["openfire_api"], forKey: "openfire_api")
        GGUserDefault.set(dic["clientUrl"], forKey: "clientUrl")
        GGUserDefault.set(dic["cloudprint_api"], forKey: "cloudprint_api")
        GGUserDefault.set(dic["cloudprint_data_api"], forKey: "cloudprint_data_api")
        GGUserDefault.set(dic["cloudmigration_api"], forKey: "cloudmigration_api")
        GGUserDefault.set(dic["elastic_api"], forKey: "elastic_api")
        GGUserDefault.set(dic["skywalking_api"], forKey: "skywalking_api")
        GGUserDefault.set(dic["space_inner_api"], forKey: "space_inner_api")
        GGUserDefault.set(dic["powerman_api"], forKey: "powerman_api")
        GGUserDefault.set(dic["chath5_url"], forKey: "chath5_url")
        
        GGUserDefault.set(dic["chatserver_api"], forKey: "chatserver_api")
    
        GGUserDefault.set(dic["point_api"], forKey: "point_api")
        GGUserDefault.set(dic["wssUrl"], forKey: "wssUrl")
        GGUserDefault.set(dic["chameleon_api"], forKey: "chameleon_api")
        GGUserDefault.set(dic["openfire_chatlet_cache"], forKey: "openfire_chatlet_cache")
        GGUserDefault.set(dic["openfire_xmpp_port"], forKey: "openfire_xmpp_port")
        GGUserDefault.set(dic["officefile_api"], forKey: "officefile_api")
        GGUserDefault.set(dic["mail_api"], forKey: "mail_api")
        GGUserDefault.set(dic["powerdude_api"], forKey: "powerdude_api")
        GGUserDefault.set(dic["inner_openfire_xmpp_host"], forKey: "inner_openfire_xmpp_host")
        GGUserDefault.set(dic["powerdude_url"], forKey: "powerdude_url")
        GGUserDefault.set(dic["hottub"], forKey: "hottub")
        GGUserDefault.set(dic["extParam"], forKey: "extParam")
        GGUserDefault.set(dic["oc-zhy-service"], forKey: "oc-zhy-service")
        GGUserDefault.set(dic["oc-zhy-openfire_http_server"], forKey: "oc-openfire_http_server-service")
        GGUserDefault.set(dic["wisdomboss"], forKey: "wisdomboss")
        GGUserDefault.set(dic["cloudmigration_inner_api"], forKey: "cloudmigration_inner_api")
        GGUserDefault.set(dic["office_api"], forKey: "office_api")
        GGUserDefault.set(dic["inner_openfire_xmpp_port"], forKey: "inner_openfire_xmpp_port")
    }
}

