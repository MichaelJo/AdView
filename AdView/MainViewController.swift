//
//  MainVc.swift
//  AdView
//
//  Created by DavidWu on 2014-10-25.
//  Copyright (c) 2014 AditMax. All rights reserved.
//

import Foundation
class MainViewController: UIViewController, UINavigationBarDelegate, UITextViewDelegate, ServerManagerDelegate  {
    let DbgName = "MainVc"
    
    let Navbar = UINavigationBar()
    let InfoText = UITextView()
    let InfoImage = UIImageView();
    let LoginButton = UIButton()
    let AdViewButton = UIButton()
    let SettingsButton = UIButton()
    let BackgdView = BackgroundView();
    let ButtonBkgd = BackgroundView();
    var adsViewed = 0;
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
        var cdb = CoreDataBase()
        cdb.clear()
        println("\(DbgName) viewDidLoad")
        super.viewDidLoad()
        var ua = UserAccountSetting()
        ua.UserListDataSysGet()
        var serverManager = ServerManager()
        serverManager.delegate = self
        serverManager.login()
        
        //UserListDataSysInit()
        //AdListAryGet()

        NavbarSet()
        LabelSet()
        ButtonsSet();
        LayoutSet()
        
        //WebView.stringByEvaluatingJavaScriptFromString("document.body.innerHTML = \"\";")
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
        
        //let BackgdView = BackgroundView();
        //self.view.addSubview(BackgdView);
        
        Navbar.translucent = false
        Navbar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "AdView: V1.1.0"
        
        let rightBkgd = UIImage(named: "BarButtonImage")!.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6), resizingMode: .Stretch)
        let rightButton = UIButton() //UIButton.buttonWithType(.Custom) as UIButton
        rightButton.setBackgroundImage(rightBkgd, forState:UIControlState.Normal);
        rightButton.setTitle(" Go ", forState: UIControlState.Normal);
        rightButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal);
        rightButton.sizeToFit();
        rightButton.addTarget(self, action: "ListAct:", forControlEvents: UIControlEvents.TouchUpInside);
        let rightItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightItem
        
        Navbar.items = [navigationItem]
        self.view.addSubview(Navbar)
    }
    func LabelSet() {
        
        InfoText.delegate = self;
        InfoText.editable = false;
        InfoText.textAlignment = NSTextAlignment.Left;
        InfoText.text = "This version is upgraded for the followings:\n"
            + "1. To support iOS 8.1 new release, iOS 8.0 was unstable.\n"
            + "2. WeChat share is added alogn with email share.\n"
            + "3. No name account is changed to guest account.\n"
            + "4. MainPpaged is modified for iApp Store audit.\n"
        InfoText.font = UIFont.systemFontOfSize(12.0);
        InfoText.textColor = UIColor.whiteColor()
        InfoText.backgroundColor = UIColor.blueColor();
        InfoText.sizeToFit();
        //self.view.addSubview(InfoText);
      
        let image = UIImage(named: "BgImage")!.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .Stretch);
        InfoImage.image = image;
        //ButtonBkgd.setB
        self.view.addSubview(InfoImage);

    }
    func ButtonsSet(){
        
        //ButtonBkgd.backgroundColor = UIColor(red: 0x2b/255.0, green: 0x65/255.0, blue: 0xec/255.0, alpha: 1.0);
        //ButtonBkgd.setB
        self.view.addSubview(ButtonBkgd);
        
        let image = UIImage(named: "SquareMeshImage")!;
        //let backButton = UIButton()
        //LoginButton.setBackgroundImage(backBkgd, forState:UIControlState.Normal);
        LoginButton.layer.cornerRadius = 0;
        LoginButton.layer.borderWidth = 2;
        LoginButton.layer.borderColor = UIColor.blackColor().CGColor;
        LoginButton.clipsToBounds = true;
        LoginButton.setTitle("Login", forState: UIControlState.Normal);
        LoginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        LoginButton.sizeToFit()
        LoginButton.backgroundColor = UIColor(patternImage: image);
        LoginButton.addTarget(self, action: "LoginAct:", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(LoginButton);
        
        AdViewButton.layer.cornerRadius = 0;
        AdViewButton.layer.borderWidth = 1;
        AdViewButton.layer.borderColor = UIColor.blackColor().CGColor;
        AdViewButton.clipsToBounds = true;
        AdViewButton.setTitle("View Ads", forState: UIControlState.Normal);
        AdViewButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        AdViewButton.sizeToFit()
        AdViewButton.backgroundColor = UIColor(patternImage: image);
        AdViewButton.addTarget(self, action: "AdViewAct:", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(AdViewButton);
        
        SettingsButton.layer.cornerRadius = 0;
        SettingsButton.layer.borderWidth = 1;
        SettingsButton.layer.borderColor = UIColor.blackColor().CGColor;
        SettingsButton.clipsToBounds = true;
        SettingsButton.setTitle("Settings", forState: UIControlState.Normal);
        SettingsButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        SettingsButton.sizeToFit()
        SettingsButton.backgroundColor = UIColor(patternImage: image);
        SettingsButton.addTarget(self, action: "SettingsAct:", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(SettingsButton);
    }
    func LayoutSet(){
        
        var layout_dict = Dictionary <String, UIView>()
        layout_dict["Navbar"] = Navbar
        Navbar.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["InfoText"] = InfoText
        InfoText.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["InfoImage"] = InfoImage
        InfoImage.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        layout_dict["BackgdView"] = BackgdView
        BackgdView.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["ButtonBkgd"] = ButtonBkgd
        ButtonBkgd.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["LoginButton"] = LoginButton
        LoginButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["AdViewButton"] = AdViewButton
        AdViewButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["SettingsButton"] = SettingsButton
        SettingsButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        //self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        //    "V:|-20-[Navbar]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[Navbar]-0-[InfoImage]-0-[LoginButton]-0-|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[Navbar]-0-[InfoImage]-0-[AdViewButton]-0-|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[Navbar]-0-[InfoImage]-0-[SettingsButton]-0-|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[Navbar]-0-[InfoImage]-0-[ButtonBkgd]-0-|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[Navbar]-0-|", options: nil, metrics: nil, views: layout_dict))
        //self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        //    "H:|-0-[LoginButton]-0-|", options: nil, metrics: nil, views: layout_dict))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: InfoImage, attribute: .Height, relatedBy:.Equal,
            toItem: LoginButton, attribute: .Height, multiplier: 3, constant: 0))
        //self.view.addConstraint(NSLayoutConstraint(
         //   item: self.view, attribute: .Height, relatedBy:.Equal,
          //  toItem: LoginButton, attribute: .Height, multiplier: 4, constant: 0))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[InfoImage]-0-|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[ButtonBkgd]-0-|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[LoginButton]-0-[AdViewButton]-0-[SettingsButton]-0-|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraint(NSLayoutConstraint(
            item: ButtonBkgd, attribute: .Height, relatedBy:.Equal,
            toItem: LoginButton, attribute: .Height, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(
            item: AdViewButton, attribute: .Width, relatedBy:.Equal,
            toItem: LoginButton, attribute: .Width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(
            item: SettingsButton, attribute: .Width, relatedBy:.Equal,
            toItem: LoginButton, attribute: .Width, multiplier: 1, constant: 0))

    }
    //----------------------------------------------------------------------------
    func LoginAct(sender:UIButton!)
    {
        println("\(DbgName) LoginAct")
        let view = UserListViewController()
        view.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        //report_view.modalTransitionStyle =
        self.presentViewController(view, animated: true, completion: nil)
    }
    func AdViewAct(sender:UIButton!)
    {
        println("\(DbgName) AdViewAct")
        GotoAdList()
    }
    func SettingsAct(sender:UIButton!)
    {
        println("\(DbgName) SettingsAct")
        let view = AdModeViewController()
        view.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        //report_view.modalTransitionStyle =
        self.presentViewController(view, animated: true, completion: nil)
    }
    //----------------------------------------------------------------------------
    func GotoAdList() {
        if (CellAry.count==0){
            let alert = UIAlertView(title: "Alert", message: "Still waiting for the AD list.",
                delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            //AdListAryGet()
            return
        }
        NSLog("\(DbgName) GotoAdListViewAct")
        
        let view = AdListViewController()
        view.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        //rate_view.modalTransitionStyle =
        view.adsViewed = self.adsViewed
        self.presentViewController(view, animated: true, completion: nil)
    }
    
    func ListAct(sender: AnyObject) {
        println("\(DbgName) goto AdListView")
        GotoAdList()
        /*
        let view = AdListViewController()
        view.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        //report_view.modalTransitionStyle =
        self.presentViewController(view, animated: true, completion: nil)
        */
    }
    
}