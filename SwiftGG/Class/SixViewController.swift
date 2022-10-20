//
//  SixViewController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/20.
//

import UIKit

class SixViewController: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.orange
        
        let btn:UIButton = UIButton(type:.custom)
        btn.frame = CGRectMake(self.view.bounds.size.width/2 - 60, 200, 120, 44)
        btn.backgroundColor = UIColor.blue
        btn.setTitle("返回", for: .normal)
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func backAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
