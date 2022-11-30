//
//  GGMeViewModel.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/30.
//

import UIKit

//我的名片-获取详情
fileprivate let GG_Code_QRcodeDetail = "/business/user/card/get?"



class GGMeViewModel
{
    static func loadPersonCardData(callBack:@escaping (_ responseData:[String : AnyObject])->())
    {
        let token = GGUserDefault.object(forKey: kGGToken) as! String
        let url = GG_ChatServer_Base_Url + GG_Code_QRcodeDetail
        
        NetworkTool.requestPersonCardDetail(url: url, params: ["token" : token], header: GG_NetWorkTool_Headers) { data in
            
            callBack(data as! [String : AnyObject])
            print(data)
            
        } failCallBack: { messageInfo in
            print(messageInfo)
        }

    }
}
