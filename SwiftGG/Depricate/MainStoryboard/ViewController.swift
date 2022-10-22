//
//  ViewController.swift
//  SwiftGG
//
//  Created by mac on 2020/12/19.
//

import UIKit
import SwiftyJSON
import HandyJSON
import Alamofire


class ViewController: UIViewController{
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white;
    }
    
    
    
    
    @IBAction func btnAction(_ sender: Any) {
        let loginVC =  LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
}

