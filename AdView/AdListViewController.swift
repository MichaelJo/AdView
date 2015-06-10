//
//  ViewController.swift
//  AdView
//
//  Created by David Wu on 2014-08-04.
//  Copyright (c) 2014 AditMax. All rights reserved.
//

import UIKit
//http://randexdev.com/2014/07/uicollectionview/
//http://suslovjb.wordpress.com/2014/06/09/create-application-without-storyboard-in-swift-language-ios8/
class AdListCellClass: UICollectionViewCell {

    var url = ""
    //let ImageView = UIImageView()
    //let TextLabel: UILabel!
    var ImageView : UIImageView!
    //required
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        //let imageFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        //ImageView = UIImageView(frame: imageFrame)

    }
    
    //override
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //let ImageView = UIImageView(frame: imageFrame)		
        let imageFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
		ImageView = UIImageView(frame: imageFrame)
        //x=>let imageFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3)
        ImageView.frame = imageFrame
        //ImageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(ImageView)
        /*
        let textFrame = CGRect(x: 0, y: ImageView.frame.size.height, width: frame.size.width, height: frame.size.height/3)
        TextLabel = UILabel(frame: textFrame)
        TextLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        TextLabel.textAlignment = .Left
        contentView.addSubview(TextLabel)
        */
    }
}


//var CellAry = [AdListDataClass]()

class AdListViewController: UIViewController, UINavigationBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,ServerManagerDelegate {

    var DbgName="AdListView"
    
    let Navbar = UINavigationBar()
    let WebView = UIWebView()
    var adsViewed = 0
    var CollectionView: UICollectionView?
    let CellIden = "Cell"
    
    func ratingSubmitted(error: String, adsViewed: Int){
        
    }
    func adsListLoaded(error: String, adsViewed: Int) {
        if (error != ""){
            let actionSheetController: UIAlertController = UIAlertController(title: "Alert", message: error, preferredStyle: .Alert)
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in
                //Do some stuff
            }
            actionSheetController.addAction(cancelAction)
            
            self.presentViewController(actionSheetController, animated: true, completion: nil)
            
        }else{
            self.adsViewed = adsViewed
        NavbarSet()
        CollectionSet()
        LayoutSet()
        }
    }
    func loginFailed(error: String) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Alert", message: "login failed, please check your current user name and password. " + error, preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        //Create and an option action
        //let nextAction: UIAlertAction = UIAlertAction(title: "Next", style: .Default) { action -> Void in
        //Do some other stuff
        //}
        //actionSheetController.addAction(nextAction)
        //Add a text field
        //actionSheetController.addTextFieldWithConfigurationHandler { textField -> Void in
        //TextField configuration
        //    textField.textColor = UIColor.blueColor()
        //}
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        println("\(DbgName) viewDidLoad")
        super.viewDidLoad()
        
        var serverManager = ServerManager()
        serverManager.delegate = self
        serverManager.login("0083532",password: "19873131")
        //let serverManager = ServerManager()
        //serverManager.setAdsList()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Let status bar show same color as navigation bar
    func positionForBar(bar: UIBarPositioning!) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
    func NavbarSet(){
        self.navigationController!.navigationBarHidden = true

        //Navbar.tintColor = UIColor.orangeColor()
        Navbar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Ad List"
                
        // Create left and right button for navigation item
        let backImg = UIImage(named: "BarBackImage");
        let backBkgd = backImg!.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 6), resizingMode: .Stretch)
        /*
        Hided main button
        let backButton = UIButton()
        backButton.setBackgroundImage(backBkgd, forState:UIControlState.Normal);
        backButton.setTitle("  Main ", forState: UIControlState.Normal);
        backButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal);    
        backButton.sizeToFit()    
        backButton.addTarget(self, action: "BackAct:", forControlEvents: UIControlEvents.TouchUpInside);
        let backItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backItem //navigationItem.backBarButtonItem
*/
        let rightImg = UIImage(named: "BarButtonImage");
        let rightBkgd = rightImg!.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6), resizingMode: .Stretch)
        let rightButton = UIButton() //UIButton.buttonWithType(.Custom) as UIButton
        rightButton.setBackgroundImage(rightBkgd, forState:UIControlState.Normal);
        rightButton.setTitle(" Refresh ", forState: UIControlState.Normal);
//        rightButton.setTitle(" View ad ", forState: UIControlState.Normal);
        rightButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal);
        rightButton.sizeToFit()    
//        rightButton.addTarget(self, action: "ItemAct:", forControlEvents: UIControlEvents.TouchUpInside);
        rightButton.addTarget(self, action: "refresh_Clicked:", forControlEvents: UIControlEvents.TouchUpInside);
        let rightItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightItem
        
        Navbar.items = [navigationItem]
        self.view.addSubview(Navbar)
    }    
    func CollectionSet(){    
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 120)
        CollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        CollectionView!.dataSource = self
        CollectionView!.delegate = self
        CollectionView!.registerClass(AdListCellClass.self, forCellWithReuseIdentifier: CellIden)
        CollectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(CollectionView!)
    }
    func LayoutSet(){
        
        var layout_dict = Dictionary <String, UIView>()
        layout_dict["Navbar"] = Navbar
        Navbar.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["CollectionView"] = CollectionView!
        CollectionView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //NSLayoutConstraint.deactivateConstraints(self.view.constraints())
        
        //self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        //    "V:|-20-[Navbar]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[Navbar]-[CollectionView]|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[Navbar]-0-|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[CollectionView]-0-|", options: nil, metrics: nil, views: layout_dict))
    }
//----------------------------------------------------------------------------          
    func BackAct(sender: AnyObject) {
        println("\(DbgName) goto MainView")
        self.dismissViewControllerAnimated(true, completion: nil);
        //self.performSegueWithIdentifier("unwindAdList2Main", sender: self)
    }
    func GotoAdItem(){
        println("\(DbgName) goto AdItemView")
        let view = AdItemViewController()
        view.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        view.adsViewed = self.adsViewed
        //report_view.modalTransitionStyle =
        self.presentViewController(view, animated: true, completion: nil)
    }
    func ItemAct(sender: AnyObject) {
        GotoAdItem()
    }
    func refresh_Clicked(sender: AnyObject) {
        refresh()
    }
    func refresh()
    {
        let serverManager = ServerManager()
        serverManager.setAdsList()
        serverManager.delegate = self
    }
    func UserAct(sender: AnyObject) {
        println("\(DbgName) go to UserListView")

//        let user_view = UserListViewController()
//        user_view.modalPresentationStyle = UIModalPresentationStyle.FormSheet
//        //report_view.modalTransitionStyle =
//        self.presentViewController(user_view, animated: true, completion: nil)
    }
    func ModeAct(sender: AnyObject) {
        println("\(DbgName) go to AdModeView")

        //let mode_view = AdModeViewController()
        //mode_view.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        //report_view.modalTransitionStyle =
        //self.presentViewController(mode_view, animated: true, completion: nil)
    }
//----------------------------------------------------------------------------      
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section:Int)->Int
    {
        return CellAry.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath)->UICollectionViewCell
    {
        println("\(DbgName) cell idx=\(indexPath.row)")
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIden, forIndexPath: indexPath) as! AdListCellClass
        cell.ImageView.image = UIImage(named: "RateImage")
        
        var idx = indexPath.row
        let cdata = CellAry[idx]
        
        if (cdata.Image != nil){
            println("\(DbgName) cell image exist id=\(cdata.AdId).")
            cell.ImageView.image = cdata.Image!
        }
        else{
            println("\(DbgName) cell image load id=\(cdata.AdId).")
            var imgURL = NSURL(string: cdata.ImgUrl)
            let request = NSURLRequest(URL: imgURL!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
                (response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error != nil{
                    println("cell image load fail idx=\(idx) ")
                    return
                }
                cdata.Image = UIImage(data: data)
                if (cdata.Image == nil) {
                    println("cell image load invalid idx=\(idx)")
                    return
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    var cell2_obj = collectionView.cellForItemAtIndexPath(indexPath)
                    if (cell2_obj == nil){
                        println("cell image cell dropped idx=\(idx).")
                        return
                    }
                    var cell2 = cell2_obj as! AdListCellClass
                    println("cell image update idx=\(idx).")
                    cell2.ImageView.image = cdata.Image
                })
            })
        }
        //scell.backgroundColor =
        //cell.titleLabel.text="\(ListArray.objectAtIndex(indexPath.item))"
        return cell
    }

    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        return CGSizeMake(300, 200)
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!)
    {
        var cell_obj = collectionView.cellForItemAtIndexPath(indexPath)
        if (cell_obj == nil){
            return
        }
        
        var cell = cell_obj as! AdListCellClass
        CellIdx = indexPath.row;
        NSLog("\(DbgName) select idx=\(CellIdx)")
        GotoAdItem()
        collectionView.deselectItemAtIndexPath(indexPath! , animated: false)
        //cell.overlayView.backgroundColor = UIColor.clearColor()
    }
    
    func collectionView(collectionView: UICollectionView!, didDeselectItemAtIndexPath indexPath: NSIndexPath!)
    {
        
        var cell_obj = collectionView.cellForItemAtIndexPath(indexPath)
        if (cell_obj == nil){
            return
        }
        
        var cell = cell_obj as! AdListCellClass
        
        //cell.overlayView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    }
    
}

