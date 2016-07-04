//
//  ViewController.swift
//  uxgent.webtopdf
//
//  Created by John Griffiths on 2016-07-02.
//  Copyright © 2016 uxgent. All rights reserved.
//

import Cocoa
import WebKit

public enum NSBitmapImageFileType : UInt {
    
    case NSTIFFFileType
    case NSBMPFileType
    case NSGIFFileType
    case NSJPEGFileType
    case NSPNGFileType
    case NSJPEG2000FileType
}

class ViewController: NSViewController {

    @IBOutlet var containerView: NSView!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //loadHTMLFile("www/index")
        loadHTMLString()
    }
    
    // load html string (working)
    func loadHTMLString() {
        let webView = WKWebView(frame: self.view.frame)
        webView.loadHTMLString("<html><body><p>Hello, World!</p></body></html>", baseURL: nil)
        self.view.addSubview(webView)
        createPDFFromView(webView, saveToDocumentWithFileName: "test.pdf")
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
        webView.allowsBackForwardNavigationGestures = false
        self.view.addSubview(webView)

        //let imgSize = webView.bounds.size
        //let bir = self.view.bitmapImageRepForCachingDisplayInRect(webView.bounds)

        //bir?.size = imgSize
        //print(imgSize)

        //webView.cacheDisplayInRect(webView.bounds, toBitmapImageRep:bir!)

        //print(self.view.canDrawSubviewsIntoLayer)
        
        //print(bir)
        
        //let image = NSImage(size:imgSize)
        //image.addRepresentation(bir!)
        
        //print(image)

        createPDFFromView(view, saveToDocumentWithFileName: "test.pdf")

        let webData = view.dataWithPDFInsideRect(view.bounds)
        let webImage = NSImage.init(data: webData)
        
        saveSnapshot(webImage!)
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

