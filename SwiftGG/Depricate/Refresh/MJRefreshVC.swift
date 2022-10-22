//
//  MJRefreshVC.swift
//  SwiftGG
//
//  Created by stoicer on 2021/1/5.
//

import UIKit

class MJRefreshVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tableView:UITableView?
    var header : MJRefreshNormalHeader?
    var footer : MJRefreshFooter?
    
    var dataArr =  [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        header = MJRefreshNormalHeader()
        footer = RefreshView()
        self.tableView?.mj_header = header
        self.tableView?.mj_footer = footer
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.header?.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.footer?.setRefreshingTarget(self, refreshingAction:#selector(footerRefresh))
        self.view.addSubview(self.tableView!)
    }
    
    func initData() {
        if self.dataArr.count > 0 {
            self.dataArr = []
        }
        self.dataArr.append("1")
        self.dataArr.append("2")
        self.tableView?.reloadData()
    }
    func addData() {
        self.dataArr.append("3")
        self.dataArr.append("4")
        self.tableView?.reloadData()
    }
    
    @objc func headerRefresh() {
        print("下拉刷新")
        self.initData()
        self.tableView?.mj_header?.endRefreshing()
    }
    
    @objc func footerRefresh() {
        print("上拉刷新")
        self.addData()
        self.tableView?.mj_footer?.endRefreshing()
    }
}



extension MJRefreshVC
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.dataArr[indexPath.row];
        return cell
    }
}
