//
//  PostDetailsViewController.swift
//  WordpressModule
//
//  Created by Afsarunnisa on 01/02/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import WebKit
//import Stencil
import RealmSwift
import idn_sdk_ios


import Mustache


class PostDetailViewController: UIViewController, WKUIDelegate, UIScrollViewDelegate,WKNavigationDelegate {
    
    var model: Post!
    static var detailTemplateFile = "post.html"

    var allPosts: Array<Any>!
    var textSize: Int = 250
    
    var currentIndex : Int = 0
    var currentPage : Int = 1
    var currentCatID : Int = 1

//    let webView : UIWebView 
    
    var currentSwipeGuesture : UISwipeGestureRecognizer = UISwipeGestureRecognizer()

    lazy var webView: WKWebView = {
        // Create preferences on how the web page should be loaded
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true

        // Create a configuration for the preferences
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences

        let webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.scrollView.delegate = self
        self.view.addSubview(webView)

        
        
        webView.allowsBackForwardNavigationGestures = true

        return webView
    }()

    @IBOutlet weak var postContentWebView: UIWebView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(ShareTapped))
        
        model = allPosts[currentIndex] as! Post
        
        self.loadData(model)

        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(PostDetailViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(PostDetailViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)

    }
    
    func ShareTapped(){
        print("add share functinality ")
        self.displayShareSheet(shareContent: model.link)
    }
    
    func respondToSwipeGesture(_ swipeGuesture: UISwipeGestureRecognizer) {
    
        currentSwipeGuesture = swipeGuesture

        if (swipeGuesture.direction == UISwipeGestureRecognizerDirection.left) {
        
            currentIndex = currentIndex + 1

            let numberOfRows : Int = allPosts.count
            
            if(numberOfRows - currentIndex < 4){
                currentPage = currentPage + 1
                
                let wordPressApiClass : WordpressApi.Type = IDS.getModuleApi("wordpress") as! WordpressApi.Type
                let wordpressAPi = wordPressApiClass.init()
                
                
//                uiActivityBar.startAnimating()
                
                wordpressAPi.getPosts(categotyID: currentCatID, itemsPerPage: 20, currentPage: currentPage, searchText: "", responseHandler: {
                    postsAry, messageApiModel, error in
                    
                    let realm = try! Realm()

                    let filterdObjects = realm.objects(Post.self).filter("ANY categories.categoryID = %@", String(self.currentCatID))
                    self.allPosts = Array(filterdObjects)

                })
            }
        
        }else{

            if(currentIndex != 0){
                currentIndex = currentIndex - 1
            }

        }
    
        model = allPosts[currentIndex] as! Post
        self.loadData(model)

    }

    
    func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
    
    
    
    func loadTemplate() -> String {

        let template = try! Template(string: model.content)
        
        // Let template format dates with `{{format(...)}}`
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        template.register(dateFormatter, forKey: "format")
        
        // The rendered data
        let data: [String: Any] = [
            "title": model.title,
            "content": model.content,
            "name": "Arthur",
            "date": Date(),
            "realDate": Date().addingTimeInterval(60*60*24*3),
            "late": true,
            "tags": model.tags.flatMap({ item in item.name }).joined(separator: ", "),
            "isAffiliate": true
        ]
        
        // The rendering: "Hello Arthur..."
        let rendering = try! template.render(data)

        
        return rendering
    
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }


}



extension PostDetailViewController {
    
    func loadData(_ model: Post? = nil) {
        // Store model if applicable
        if model != nil {
            self.model = model
        }
        
        let contentStr = "<div width: 100%; style='font-family:Roboto; padding:10; word-wrap: break-word;'>\((model?.content)!)</div>"
        
        let str = "<body style='margin:0; padding:0'>\(contentStr)</body>"
        
        
        webView.loadHTMLString(str, baseURL: nil)
        
        webView.evaluateJavaScript("document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(textSize)%%'", completionHandler: nil)

        
        
//        if(animation == true){
            let location = currentSwipeGuesture.location(in: self.view)
            
            if self.webView.point(inside: location, with: nil){
                
                let animation : CATransition = CATransition()
                animation.type = kCATransitionPush
                animation.duration = TimeInterval(1.0)
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                animation.fillMode = kCAFillModeForwards
                
                if currentSwipeGuesture.direction == UISwipeGestureRecognizerDirection.left {
                    animation.subtype = kCATransitionFromRight
                }else if currentSwipeGuesture.direction == UISwipeGestureRecognizerDirection.right{
                    animation.subtype = kCATransitionFromLeft
                }
                
                self.webView.layer.add(animation, forKey: nil)
//                self.subArticlesListTableView.layer.add(animation, forKey: nil)
                
            }
//        }
    }
}


// MARK: - Web view functions
extension PostDetailViewController {
   
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Start the network activity indicator when the web view is loading
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Stop the network activity indicator when the loading finishes
        
        webView.evaluateJavaScript("document.documentElement.style.webkitUserSelect='none';", completionHandler: nil)
        
        webView.evaluateJavaScript("document.documentElement.style.webkitTouchCallout='none';", completionHandler: nil)
        
        webView.evaluateJavaScript("document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(textSize)%%'", completionHandler: nil)

        
        
//        webView.stringByEvaluatingJavaScript(from: "document.documentElement.style.webkitUserSelect='none';")!
//        // Disable callout
//        webView.stringByEvaluatingJavaScript(from: "document.documentElement.style.webkitTouchCallout='none';")!
//        webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(textSize)%%'")

        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Display navigation/toolbar when scrolled to the bottom
        guard scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) else { return }
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setToolbarHidden(false, animated: true)
    }


}

