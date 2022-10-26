//
//  GGWebViewController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/26.
//

import UIKit
import WebKit

class GGWebViewController: BaseVC,WKNavigationDelegate,WKUIDelegate {
    
    
    var urlString:String
    //关于初始化介绍： https://www.jianshu.com/p/fb1a91600468
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.urlString = ""
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var webView : WKWebView =
    {
        let tempWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavgationBarHeight))
        
        tempWebView.uiDelegate = self;
        tempWebView.navigationDelegate = self;
        
        return tempWebView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar(hidden: false)
        self.setupUI()
    }
    
    func setNavBar(hidden:Bool)
    {
        
        let backItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem = backItem
        self.navigationController?.setNavigationBarHidden(hidden, animated: true)
    }
    
    func setupUI() {
        self.view.addSubview(webView)
    }
    
    func getTitle() {
        
        webView.evaluateJavaScript("document.title") { [weak self] titleStr, error in
            if (error == nil && (titleStr as? String)!.count > 0)
            {
                self?.navigationItem.title = titleStr as? String
            }
            else
            {
                self?.navigationItem.title = "title"
            }
        }
    }
    
    public func doRequest(myUrl:String)
    {
        let url = URL(string: myUrl)
        let request : NSURLRequest? = NSURLRequest(url: url!, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 15)
        webView.load(request! as URLRequest)
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension GGWebViewController
{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        return WKNavigationActionPolicy.allow
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        print("didFinish navigation")
        self.getTitle()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail navigation")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit navigation")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        return completionHandler()
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        return completionHandler(true)
    }
}

