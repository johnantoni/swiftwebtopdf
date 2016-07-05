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

public enum NSBitmapImageFileType : UInt {
    
    case NSTIFFFileType
    case NSBMPFileType
    case NSGIFFileType
    case NSJPEGFileType
    case NSPNGFileType
    case NSJPEG2000FileType
}

class ViewController: NSViewController {
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadHTMLFile("www/index")
    }
    
    func loadHTMLString() {
        let webView = WKWebView(frame: self.view.frame)
        webView.loadHTMLString("<html><body><p>Hello, World!</p></body></html>", baseURL: nil)
        self.view.addSubview(webView)
        createPDFFromView(webView, saveToDocumentWithFileName: "test.pdf")
    }
    
    func loadURL() {
        let webView = WKWebView(frame: self.view.frame)
        let url = NSURL(string: "https://www.google.ca")
        let req = NSURLRequest(URL: url!)
        webView.loadRequest(req)
        self.view.addSubview(webView)
    }
    
    func loadHTMLFile(fileName: String) {
        let webView = WebView(frame: self.view.frame)
        let localfilePath = NSBundle.mainBundle().URLForResource(fileName, withExtension: "html");
        let req = NSURLRequest(URL: localfilePath!);
        webView.mainFrame.loadRequest(req)
        self.view.addSubview(webView)
        
        // needs 1 second delay
        let delay = 1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            // works!
            let data = webView.dataWithPDFInsideRect(webView.frame)
            let doc = PDFDocument.init(data: data)
            doc.writeToFile("/Users/john/Desktop/test.pdf")
            
            // works!
            let printInfo = NSPrintInfo.sharedPrintInfo()
            let printOperation = NSPrintOperation(view: webView.mainFrame.frameView, printInfo: printInfo)
            printOperation.runOperation()
        }
    }
    
    func saveSnapshot(img: NSImage)
    {
        if let bits = img.representations.first as? NSBitmapImageRep {
            print(bits)
            let data = bits.representationUsingType(.NSPNGFileType, properties: [:])
            data?.writeToFile("/Users/john/Documents/test.png", atomically: true)
        }
    }
    
    func createPDFFromView(view: NSView, saveToDocumentWithFileName fileName: String) {
        let pdfData = view.dataWithPDFInsideRect(view.bounds)
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first {
            let documentsFileName = documentDirectories + "/" + fileName
            debugPrint(documentsFileName)
            pdfData.writeToFile(documentsFileName, atomically: false)
        }
    }
    
}

