//
//  SearchDetailViewController.swift
//  PubFinder
//
//  Created by Christelle Lorin on 2/18/18.
//  Copyright © 2018 Christelle Lorin. All rights reserved.
//

import UIKit
import WebKit

class SearchDetailViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView?
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // make an activityindicator spinner
        // tell it to start animating
        
        guard let detailURLString = urlString else {
            return
        }
        guard let url = URL(string: detailURLString) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        webView = WKWebView(frame: view.frame)
        guard let webView = webView else {
            return
        }
        webView.navigationDelegate = self
        webView.load(urlRequest)
        view.addSubview(webView)
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //succes
        
        // activity spinner to stop animating
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("ERRO\(error)")
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

