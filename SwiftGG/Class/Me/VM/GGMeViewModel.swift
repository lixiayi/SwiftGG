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
    //存储请求的数据模型
    var model : GGMeModel? = GGMeModel()
    
    func loadPersonCardData(callBack:@escaping ()->())
    {
        let token = GGUserDefault.object(forKey: kGGToken) as! String
        let url = GG_ChatServer_Base_Url + GG_Code_QRcodeDetail
        
        NetworkTool.requestPersonCardDetail(url: url, params: ["token" : token], header: GG_NetWorkTool_Headers) { data in
            
            //解析数据
            guard let dic = data as? [String : Any] else { return }
            guard let dict = dic["data"] as? [String : Any] else { return }
            
            //字典->模型
            self.model = GGMeModel.deserialize(from: dict, designatedPath: nil)
        
            callBack()
            print(data)
            
        } failCallBack: { messageInfo in
            print(messageInfo)
        }
    }
}
