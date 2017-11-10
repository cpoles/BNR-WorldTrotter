//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Carlos Poles on 10/11/17.
//  Copyright © 2017 Carlos Poles. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    
    var webView: WKWebView!
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("WebViewController loaded its view.")
        
        // create the http request for the webview to load.
        let myURL = URL(string: "https://www.bignerdranch.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }
    
    
}
