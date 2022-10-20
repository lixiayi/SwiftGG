//
//  FirstViewController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/19.
//

import UIKit

class FirstViewController: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.red
        
        self.navigationItem.title = "第一个VC"
     
        let btn:UIButton = UIButton(type:.custom)
        btn.frame = CGRectMake(self.view.bounds.size.width/2 - 60, 200, 120, 44)
        btn.backgroundColor = UIColor.blue
        btn.setTitle("popvc", for: .normal)
        btn.addTarget(self, action: #selector(btnAction(sender:)), for: .touchUpInside)
        self.view.addSubview(btn)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func btnAction(sender:UIButton) {
        print("点击了按钮")
        let vc = FiveViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
