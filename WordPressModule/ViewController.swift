//
//  ViewController.swift
//  WordpressModule
//
//  Created by Afsarunnisa on 24/01/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import idn_sdk_ios
import RealmSwift
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var postsTableView: UITableView!
    
    var topMenuView: BTNavigationDropdownMenu!
    var posts : Array<Any>! = []
    
    var currentCatID : Int = 0
    var totalRowsWithPages : Int = 0
    let itemsPerPgae : Int = 20
    
    var currentPage : Int = 1
    var isLoading : Bool = false
    @IBOutlet weak var menuButton:UIBarButtonItem!

    var categoriesAry : Array<Any> = []

    
    let uiActivityBar = UIActivityIndicatorView(activityIndicatorStyle: .white)
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let wordPressApiClass : WordpressApi.Type = IDS.getModuleApi("wordpress") as! WordpressApi.Type
        let wordpressAPi = wordPressApiClass.init()
        
        
    
        
        
        self.getArticles(categotyId: 5013)
        
        
        wordpressAPi.getCategories(parentID: "5013", itemsPerPage: "20", responseHandler: {
            
            categories, messageApiModel, error in
            
            let realm = try! Realm()
            let categories = realm.objects(Category.self)
            
            for i in 0..<categories.count {
                let category = categories[i]
                self.categoriesAry.append(category.name)
            }
            
            self.topMenuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "All", items: self.categoriesAry as [AnyObject])
            self.topMenuView.cellHeight = 50
            self.topMenuView.cellBackgroundColor = UIColor(red: 237.0/255.0, green:143.0/255.0, blue:64.0/255.0, alpha: 1.0)
            self.topMenuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
            self.topMenuView.shouldKeepSelectedCellColor = true
            self.topMenuView.cellTextLabelColor = UIColor.white
            self.topMenuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
            self.topMenuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
            self.topMenuView.arrowPadding = 15
            self.topMenuView.animationDuration = 0.5
            self.topMenuView.maskBackgroundColor = UIColor.black
            self.topMenuView.maskBackgroundOpacity = 0.3
            
            
            self.topMenuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
                let selectedCategory : Category = categories[indexPath]
                self.getArticles(categotyId: selectedCategory.id)
            }
            self.navigationItem.titleView = self.topMenuView
        })
        
        
        
        
        postsTableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view, typically from a nib.
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        postsTableView.tableHeaderView = searchController.searchBar
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: uiActivityBar)
        
    }
    
    
    public func menuAction(imgName: String, menuView : AnyObject, completionHandler: @escaping (UIBarButtonItem?, NSError?) -> ()) {
        
        //        if menuView != nil {
        menuButton.target = menuView
        self.view.addGestureRecognizer(menuView.panGestureRecognizer)
        //        }
        
        completionHandler(menuButton, nil)
    }
    
    
    func getArticles(categotyId : Int){
        
        let wordPressApiClass : WordpressApi.Type = IDS.getModuleApi("wordpress") as! WordpressApi.Type
        let wordpressAPi = wordPressApiClass.init()
        
        currentCatID = categotyId
        
        print("self.posts \(self.posts)")
        
        if(self.posts.count == 0 || self.posts.count < 10){
            
            self.uiActivityBar.startAnimating()
            
            wordpressAPi.getPosts(categotyID: categotyId, itemsPerPage: itemsPerPgae, currentPage: currentPage, searchText: "", responseHandler: {
                postsAry, messageApiModel, error in
                
                
                self.uiActivityBar.stopAnimating()
                
                self.postsTableView.reloadData()
            })
        }else{
            self.postsTableView.reloadData()
        }
    }
    
    
    
    
    
    
    // MARK: - Tableview delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let realm = try! Realm()
        
        
        if(searchController.isActive && searchController.searchBar.text != ""){
            
            let predicate = NSPredicate(format: "title contains[c] %@", searchController.searchBar.text!)
            
            let filterdObjects = realm.objects(Post.self).filter("ANY categories.categoryID = %@", String(currentCatID))
            
            let filterdList = filterdObjects.filter(predicate)
            
            self.posts = Array(filterdList)
            
        }else{
            
            let filterdObjects = realm.objects(Post.self).filter("ANY categories.categoryID = %@", String(currentCatID))
            
            self.posts = Array(filterdObjects)
            
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchController.isActive && searchController.searchBar.text != ""){
            
        }else{
            return posts?.count ?? 0
        }
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticlesCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        
        let post : Post = posts[indexPath.row] as! Post
        
        cell.titleLabel.text = post.title
        cell.descLabel.text = post.excerpt
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailVC") as! PostDetailViewController
        
        let post : Post = posts[indexPath.row] as! Post
        
        postViewController.model  = post
        postViewController.allPosts = posts
        postViewController.currentIndex = indexPath.row
        postViewController.currentPage = currentPage
        postViewController.currentCatID = currentCatID
        
        
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height
        if (endScrolling >= scrollView.contentSize.height){
            
            currentPage = currentPage + 1
            
            //        get articles list
            let wordPressApiClass : WordpressApi.Type = IDS.getModuleApi("wordpress") as! WordpressApi.Type
            let wordpressAPi = wordPressApiClass.init()
            
            
            uiActivityBar.startAnimating()
            
            wordpressAPi.getPosts(categotyID: currentCatID, itemsPerPage: itemsPerPgae, currentPage: currentPage, searchText: "", responseHandler: {
                postsAry, messageApiModel, error in
                
                self.uiActivityBar.stopAnimating()
                
                self.postsTableView.reloadData()
            })
        }
    }    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func filterdContentForSearchText(searchText : String, scopr : String = "All"){
        
        postsTableView.reloadData()
    }
    
    
}


extension ViewController : UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.filterdContentForSearchText(searchText: searchController.searchBar.text!)
        
        print("searchController \(searchController)")
        
    }
}
