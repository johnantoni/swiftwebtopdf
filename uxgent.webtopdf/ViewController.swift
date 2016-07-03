//
//  ViewController.swift
//  uxgent.webtopdf
//
//  Created by John Griffiths on 2016-07-02.
//  Copyright © 2016 uxgent. All rights reserved.
//

import Cocoa
import WebKit
import Quartz

class ViewController: NSViewController {

    @IBOutlet var containerView: NSView!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadHTMLFile("www/index")
    }
    
    // load html string (working)
    func loadHTMLString() {
        let webView = WKWebView(frame: self.view.frame)
        webView.loadHTMLString("<html><body><p>Hello, World!</p></body></html>", baseURL: nil)
        self.view.addSubview(webView)
    }
    
    // load url (working)
    func loadURL() {
        let webView = WKWebView(frame: self.view.frame)
        let url = NSURL(string: "https://www.google.ca")
        let req = NSURLRequest(URL: url!)
        webView.loadRequest(req)
        self.view.addSubview(webView)
    }
    
    //load a local html file (working)
    func loadHTMLFile(fileName: String) {
        let webView = WKWebView(frame: self.view.frame)
        let localfilePath = NSBundle.mainBundle().URLForResource(fileName, withExtension: "html");
        let req = NSURLRequest(URL: localfilePath!);
        webView.loadRequest(req)
        self.view.addSubview(webView)
        
        createPDFFromView(webView, saveToDocumentWithFileName: "test.pdf")
    }
    
    func createPDFFromView(aView: NSView, saveToDocumentWithFileName fileName: String) {
        let pdfData = aView.dataWithPDFInsideRect(aView.frame)
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first {
            let documentsFileName = documentDirectories + "/" + fileName
            debugPrint(documentsFileName)
            pdfData.writeToFile(documentsFileName, atomically: true)
        }
    }
    
}

