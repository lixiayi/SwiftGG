//
//  GGWebViewController.swift
//  SwiftGG
//
//  Created by stoicer on 2022/10/26.
//

import UIKit
import WebKit

//js执行OC的接口
let JSToOC  = "jsToOc"

class GGWebViewController: BaseVC,WKNavigationDelegate,WKUIDelegate, WKScriptMessageHandler {
    
    var urlString:String
    
    // MARK: - Init
    //关于初始化介绍： https://www.jianshu.com/p/fb1a91600468
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.urlString = ""
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lazy
    lazy var webView : WKWebView =
    {
        //configuration
        let configuration = WKWebViewConfiguration()
        let wkUserController = WKUserContentController()
        
        //注入js调用OC的方法
        //弱引用
        let weakObj = GGWeakHandler(hander: self)
        
        wkUserController.add(weakObj, name: JSToOC)
        
        configuration.userContentController = wkUserController
        
        // preferences
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        configuration.preferences = preferences
        
        let tempWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavgationBarHeight),configuration: configuration)
        
        //回弹
        tempWebView.scrollView.bounces = true
        
        //只能上下移动
        tempWebView.scrollView.alwaysBounceVertical = true
        
        //设置代理
        tempWebView.uiDelegate = self;
        tempWebView.navigationDelegate = self;
        
        return tempWebView
    }()
    
    
    // MARK: - Life
    deinit
    {
        self.webView.configuration.userContentController.removeScriptMessageHandler(forName: JSToOC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavBar(hidden: false)
        self.setupUI()
    }
    
    // MARK: - UI
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
    
    // MARK: - Action
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
    // MARK: - navigationDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        return WKNavigationActionPolicy.allow
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        print("didFinish navigation")
        self.getTitle()
        
        //OC执行JS
        webView.evaluateJavaScript("sayHello('webView>>>hello')") { result, error in
            guard let rst = result else {
                return
            }
            
            print(rst)
        }
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

    
    // MARK: - UIDelegate
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        return completionHandler()
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        return completionHandler(true)
    }
    
    // MARK: - JS->OC
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        if (message.name == JSToOC)
        {
            print("jsToOc do")
        }
    }
}

