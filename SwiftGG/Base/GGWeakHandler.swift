//
//  GGWeakHandler.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/27.
//

import UIKit
import WebKit

class GGWeakHandler : NSObject,WKScriptMessageHandler {
    
    //定义一个weak弱引用类型变量
    weak var handler : AnyObject?

    //自己的Init
    override init() {
        super.init()
    }
    
    init(hander:NSObject) {
        self.handler = hander
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        //responseToSelector in swift  可空链
        //https://www.jianshu.com/p/da44d1fd8440
        self.handler?.userContentController?(userContentController, didReceive: message)
    }
    
    
}


