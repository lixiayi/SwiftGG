//
//  Constant.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/19.
//

import Foundation

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kNavgationBarHeight = 44.0
let kStatusBarH : CGFloat = 20
let kHomeIndicatorH : CGFloat = 34.0

let kMeNoUserDescription = "这个家伙很懒，什么都没留下"

//APP主题色
let kAppThemeColor = UIColor.colorWithHex(hex:"#108ee9")

//cell分隔线颜色
let kCellSepColor = UIColor.colorWithHex(hex: "#e1e2e3")

/**************************  UserDefault用到Key  ***************************/
let GGUserDefault = UserDefaults.standard

//登录使用到的公钥
let kLoginPublicKey = "kLoginPublicKey"

//域名信息保存
let kCompanyInfoKey = "kCompanyInfoKey"

//登录后token
let kGGToken = "kGGToken"

//登录后保存用户名
let kGGUserName = "kGGUserName"

//登录后保存头像
let kGGAvatar = "kGGAvatar"

//登录后保存用户姓名
let kGGName = "kGGName"

//登录后保存im状态
let kImState = "kImState"

//分享桌面
let kFreeDesk = "kFreeDesk"

//im账号
let kIMAccount = "kIMAccount"

//im密码
let kIMPwd = "kIMPwd"

//用户是否vip
let kIsVIP = "kIsVIP"

//昵称列表
let kNickName_list = "kNickName_list"

//模板列表
let kTemplate_info = "kTemplate_info"

//系统信息
let kUserSysInfo = "kUserSysInfo"

//公司信息 - public版本
let kBranchCompaniesInfo = "kBranchCompaniesInfo"

//权限列表
let kAuth_list = "kAuth_list"

