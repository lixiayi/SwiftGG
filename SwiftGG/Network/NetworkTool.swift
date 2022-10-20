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

class NetworkTool {
    
    /** 成功回调 */
    typealias successCallBack = ((_ data:Any)->())?

    /** 失败回调 */
    typealias failureCallBack = ((_ error:Error)->())?
    
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
                    failCallBack!(data.result.error!)
                }
            }
        }
    }
    
    
}
