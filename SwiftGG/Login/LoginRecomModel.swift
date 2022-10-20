//
//  LoginRecomModel.swift
//  SwiftGG
//
//  Created by stoicer on 2021/1/10.
//

import Foundation
import HandyJSON

class LoginRecomModel: HandyJSON {
    
    required init() {
        
    }
    var mail_api: String = ""
    var openfire_bosh: String = ""
    var chameleon_api: String = ""
    var openfire_xmpp_port : Int = 0
    var recommend_enable:Bool = false
    var domain: String = ""
    var openfire_chatlet_cache: String = ""
    var chatserver_id:Int = 0
    var company_name: String = ""
    var search_enable:Bool = false
    var recommend_image: String = ""
    var chatserver_api: String = ""
    var sort:Int = 0
    var space_api:String = ""
    var openfire_xmpp_host:String = ""
}





