# swiftwebtopdf
small little swift osx app that allows loading content into webview &amp; view via multiple sources then outputting to pdf.

# how to

first define your webview

    let webView = WKWebView(frame: self.view.frame)
    
next you can send content to the webview via:

## via html string

    webView.loadHTMLString("<html><body><p>Hello, World!</p></body></html>", baseURL: nil)
    self.view.addSubview(webView)
    
## via url

    let url = NSURL(string: "https://www.google.ca")
    let req = NSURLRequest(URL: url!)
    webView.loadRequest(req)
    self.view.addSubview(webView)

## via local html file

note: this loads referenced css file & runs the js in the html file

    let localfilePath = NSBundle.mainBundle().URLForResource("www/index", withExtension: "html");
    let req = NSURLRequest(URL: localfilePath!);
    webView.loadRequest(req)
    self.view.addSubview(webView)
