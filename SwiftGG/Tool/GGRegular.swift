//
//  GGRegular.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/23.
//  常用的正则表达式

import Foundation

class GGRegular {
    
    //验证邮箱
    // MARK: - 验证邮箱
    static func validateEmail(email:String) ->Bool
    {
        
        if email.count == 0
        {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }

    // MARK: - 验证手机号码
    static func isPhoneNumber(phoneNumber:String) -> Bool
    {
        if phoneNumber.count == 0
        {
            return false
        }
        
        let mobile = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: phoneNumber) == true {
            return true
        }
        else
        {
            return false
        }
    }
    
    // MARK: - 验证密码 6-8位字母和数字组合
   static  func isPassword(pwd:String) -> Bool
    {
        let passwordRule = "^(?![0-9]+$)(?![a-zA-Z]+$){6,8}$"
        let regex = NSPredicate(format: "SELF MATCHES %@", passwordRule)
        if (regex.evaluate(with: pwd) == true)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    // MARK: - 验证URL
    static func isUrl(url:String) ->Bool
    {
        let urlRule: String = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        
        let regex = NSPredicate(format: "SELF MATCHES %@", urlRule)
        if (regex.evaluate(with: url) == true)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    // MARK: - 验证汉字
    static func isChinese(str:String) -> Bool
    {
        let isChinese: String = "[\\u4e00-\\u9fa5]"
        let regex = NSPredicate(format: "SELF MATCHES %@", isChinese)
        if (regex.evaluate(with: str) == true)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    // MARK: - 验证配置身份证
    static func isIdNum(str:String) -> Bool
    {
        let idRule: String =  "\\d{15}(\\d\\d[0-9xX])?"
        let regex = NSPredicate(format: "SELF MATCHES %@", idRule)
        if (regex.evaluate(with: str) == true)
        {
            return true
        }
        else
        {
            return false
        }
    }
}
