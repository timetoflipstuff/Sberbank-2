//
//  SignInViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit
import WebKit

class SignInViewController: UIViewController {
    
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(webView)
        webView.frame = view.frame
        webView.navigationDelegate = self
        
        let request = NetworkManager.shared.getAuthRequest()
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    
    
}


extension SignInViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let html = html as? String else { return }
            
            //TODO: Add activity indicator
            if let token = html.slice(from: "<pre>", to: "</pre>") {
                AppDelegate.defaults.set(token, forKey: "token")
                AppDelegate.shared.rootViewController.switchToMainScreen()
            }
            
            
        }
        
        
    }
}


