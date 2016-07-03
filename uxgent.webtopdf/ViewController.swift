//
//  ViewController.swift
//  uxgent.webtopdf
//
//  Created by John Griffiths on 2016-07-02.
//  Copyright © 2016 uxgent. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    @IBOutlet var containerView: NSView!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let webView = WKWebView(frame: self.view.frame)
        
        // load html string (working)
        //webView.loadHTMLString("<html><body><p>Hello, World!</p></body></html>", baseURL: nil)
        //self.view.addSubview(webView)
        
        // load url (working)
        //let url = NSURL(string: "https://www.google.ca")
        //let req = NSURLRequest(URL: url!)
        //webView.loadRequest(req)
        //self.view.addSubview(webView)
        
        //load a local html file (working)
        let localfilePath = NSBundle.mainBundle().URLForResource("www/index", withExtension: "html");
        let req = NSURLRequest(URL: localfilePath!);
        webView.loadRequest(req)
        self.view.addSubview(webView)
    }
    
}

