//
//  GGMeModel.swift
//  SwiftGG
//
//  Created by stoicer on 2022/11/30.
//

import Foundation
import HandyJSON

class GGMeModel : HandyJSON
{
    var share_url : String = ""
    
    var public_company :Bool = false
    
    var location :String = ""
    
    var official_position :String = ""
    
    var public_branch :Bool = false

    var to_tags :[String]?
    
    var remark :[String]?
    
    var public_position :Bool = false
    
    var nicknames :[String]?
    
    var public_nickname :Bool = false
    
    var background_url: String = ""
    
    var qrcode_url : String = ""
    
    var card_id : Int = 0
    
    var name : String = ""
    
    var  position: String = ""
    
    var branches:[String]?
    
    var public_email: Bool = false
    
    var company: String = ""
    
    var public_mobile: Bool = false
    
    var avatar_url: String = ""
    
    var mobile: String = ""
    
    var email: String = ""
    
    var introduction: String = ""
    
    required init() {
        
    }
}
