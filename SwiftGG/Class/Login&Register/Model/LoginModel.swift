//
//  LoginModel.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/30.
//

import UIKit
/*
 
 "chatserver_api" = "https://chanpin-chatoc.onecloud.cn";
 "chatserver_id" = 26;
 domain = "\U4ea7\U54c1";
 "im_user_name" = 7f34dffdd5a04e699fa7d6133de2d;
 "im_user_pwd" = de0908;
 "recommend_image" = "https://chanpin-chatoc.onecloud.cn/file/customize/template/890da720-14d1-42e0-9940-db138f3b7cc0.jpg";
 tacit = 0;
 uid = 9342;
 "updated_at" = 1666798240000;
 */

class LoginModel : NSObject {
    /** ⚠️ 如果要用KVC方式通过字典给model赋值，需要在定义属性前写上 @objc ⚠️*/
    
    //域名api地址
    @objc var chatserver_api : String? = ""
    //域名ID 赋初值
    @objc  var chatserver_id : Int = 0
    //域名名称
    @objc var domain : String? = ""
    //GG号
    @objc var im_user_name: String? = ""
    //GG密码
    @objc var im_user_pwd : String? = ""
    //图片
    @objc var recommend_image : String? = ""
    //是否默认 赋初值
    @objc var tacit:Int = 0

    init(dict : Dictionary<String, AnyObject>) {
        super.init()
        // setValuesForKeysWithDictionary 已经被改成了setValuesForKeys
        self.setValuesForKeys(dict)
    }
    
    //重写
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
