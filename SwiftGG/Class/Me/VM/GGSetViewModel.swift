//
//  GGSetViewModel.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/27.
//

import UIKit

let GG_LOGOUT_URL =  "/business/user/logout?"


class GGSetViewModel {
    
    static func loadData(callBack : @escaping ()->())
    {
        let token = GGUserDefault.object(forKey: kGGToken) as! String
        let url = GG_ChatServer_Base_Url +  GG_LOGOUT_URL
        
        NetworkTool.requestLoginOut(url: url, params: ["token" : token], header: GG_NetWorkTool_Headers) { data in
            print(data)
            callBack()
            
        } failCallBack: { messageInfo in
            print(messageInfo)
        }
    }
}
