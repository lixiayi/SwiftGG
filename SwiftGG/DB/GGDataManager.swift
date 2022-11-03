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


