//
//  UserProfileViewController.swift
//  AdViewer
//
//  Created by Alex Li Song on 2015-05-10.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController,UINavigationBarDelegate,UIWebViewDelegate,UIScrollViewDelegate {
    let Navbar = UINavigationBar()
    //let Toolbar = UIToolbar() as UIToolbar
    let AdsFld = UITextField() as UITextField
    let StatFld = UITextField() as UITextField

    var WebView: UIWebView?
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.x > 0){
            scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y)
        }
    }
    
    func initNavigationBar()
    {
        self.navigationController?.navigationBarHidden = true
        var view_bar = UIView()
        view_bar.frame = CGRectMake(0, 0, self.view.frame.size.width, 64)
        var imageV = UIImageView(frame: CGRectMake(0, 0,self.view.frame.size.width, 64))
        imageV.image = BundleImage("top.png")
        view_bar.addSubview(imageV)
        view_bar.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(view_bar)
        
    /*self.navigationController.navigationBarHidden = YES;
    UIView *view_bar =[[UIView alloc]init];
   
    view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44+20);
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 44+20)];
    imageV.image = BundleImage(@"top.png");
    [view_bar addSubview:imageV];
    [imageV release];
    
    
    view_bar.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview: view_bar];
    
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"设置";
    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    //    title_label.shadowColor = [UIColor darkGrayColor];
    //    title_label.shadowOffset = CGSizeMake(1, 1);
    [view_bar addSubview:title_label];
    
    UIButton*btnBack=[UIButton buttonWithType:0];
    btnBack.frame=CGRectMake(0, view_bar.frame.size.height-34, 47, 34);
    [btnBack setImage:BundleImage(@"ret_01.png") forState:0];
    [btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnBack];
    
    return view_bar;*/
    }

    override func viewDidLoad() {
        //[super viewDidLoad];
        
        //[self.view setBackgroundColor:[UIColor whiteColor]];
        //self.navigationController.navigationBarHidden = YES;

        
        super.viewDidLoad()
        //self.initNavigationBar()
        NavbarSet()
        WebViewSet()
        LayoutSet()
        

        //WebView.stringByEvaluatingJavaScriptFromString("document.body.innerHTML = \"\";")

        WebView!.stopLoading()
        
        let url0 = NSURL(string: "about:blank")
        let request0 = NSURLRequest(URL: url0!)
        WebView!.loadRequest(request0)
        
        let url = NSURL(string: "http://rshankar.com")
        let request = NSURLRequest(URL: url!)
        WebView!.loadRequest(request)
    }
    func positionForBar(bar: UIBarPositioning!) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
    func BackAct(sender: AnyObject){
        self.navigationController?.popViewControllerAnimated(true)

    }
    func NavbarSet(){
        
        //Navbar.tintColor = UIColor.orangeColor()
        Navbar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Ad View"
        
        // Create left and right button for navigation item
        let backImg = UIImage(named: "BarBackImage");
        let backBkgd = backImg!.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 6), resizingMode: .Stretch)
        let backButton = UIButton()
        backButton.setBackgroundImage(BundleImage("ret_01.png"), forState:UIControlState.Normal);
        //backButton.setTitle("  List ", forState: UIControlState.Normal);
        backButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal);
        backButton.sizeToFit()
        backButton.addTarget(self, action: "BackAct:", forControlEvents: UIControlEvents.TouchUpInside);
        let backItem = UIBarButtonItem(customView: backButton)
        
        //UIButton*btnBack=[UIButton buttonWithType:0];
        //btnBack.frame=CGRectMake(0, view_bar.frame.size.height-34, 47, 34);
        //[btnBack setImage:BundleImage(@"ret_01.png") forState:0];
        //[btnBack addTarget:self action:@selector(btnBack:) forControlEvents:UIControlEventTouchUpInside];
        //[view_bar addSubview:btnBack];

 //       self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        navigationItem.leftBarButtonItem = backItem //navigationItem.backBarButtonItem
        /*
        let rightImg = UIImage(named: "BarButtonImage");
        
        
        let rightBkgd = rightImg!.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6), resizingMode: .Stretch)
        let rightButton = UIButton() //UIButton.buttonWithType(.Custom) as UIButton
        rightButton.setBackgroundImage(rightBkgd, forState:UIControlState.Normal);
        rightButton.setTitle(" Menu ", forState: UIControlState.Normal);
        rightButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal);
        rightButton.sizeToFit()
        rightButton.addTarget(self, action: "Bar2Menu:", forControlEvents: UIControlEvents.TouchUpInside);
        let rightItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightItem
        */
        Navbar.items = [navigationItem]
        self.view.addSubview(Navbar)
    }
    /*
    func ToolbarSet(){
    let ListButton = UIBarButtonItem(title: "< List", style: UIBarButtonItemStyle.Plain, target: self, action: "ListAct:")
    let flex1Button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    let RateButton = UIBarButtonItem(image: UIImage(named: "RateImage"), style: UIBarButtonItemStyle.Bordered, target: self, action: "RateAct:")
    let ShareButton = UIBarButtonItem(image: UIImage(named: "ShareImage"), style: UIBarButtonItemStyle.Bordered, target: self, action: "ShareAct:")
    let ReportButton = UIBarButtonItem(image: UIImage(named: "ReportImage"), style: UIBarButtonItemStyle.Bordered, target: self, action: "ReportAct:")
    let flex2Button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    let GoLastButton = UIBarButtonItem(image: UIImage(named: "GoLastImage"), style: UIBarButtonItemStyle.Bordered, target: self, action: "GoLastAct:")
    let GoNextButton = UIBarButtonItem(image: UIImage(named: "GoNextImage"), style: UIBarButtonItemStyle.Bordered, target: self, action: "GoNextAct:")
    let flex3Button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
    let InfoButton = UIBarButtonItem(image: UIImage(named: "InfoImage"), style: UIBarButtonItemStyle.Bordered, target: self, action: "InfoAct:")
    var ToolbarButtons = [ListButton,flex1Button,RateButton,ShareButton,ReportButton,flex2Button,GoLastButton,GoNextButton,flex3Button,InfoButton]
    
    Toolbar.setItems(ToolbarButtons, animated: true)
    Toolbar.sizeToFit()
    Toolbar.barStyle = UIBarStyle.Black
    Toolbar.backgroundColor = UIColor.blackColor()
    self.view.addSubview(Toolbar)
    }
    */
     func WebViewSet() {
        
        WebView = UIWebView(frame: self.view.frame) as UIWebView
        
        WebView!.scalesPageToFit = true
        
        WebView!.delegate = self
        self.view.addSubview(WebView!)
        
        WebView!.scrollView.delegate = self
        WebView!.scrollView.showsHorizontalScrollIndicator = false
        WebView!.scrollView.bounces = false;
        
        //WebView.stringByEvaluatingJavaScriptFromString("document.body.innerHTML = \"\";")
    }
    func LayoutSet(){
        
        var layout_dict = Dictionary <String, UIView>()
        layout_dict["Navbar"] = Navbar
        Navbar.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["WebView"] = WebView!
        WebView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //NSLayoutConstraint.deactivateConstraints(self.view.constraints())
        
        //self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        //    "V:|-20-[Navbar]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[Navbar]-10-[WebView]|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[Navbar]-0-|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[WebView]-0-|", options: nil, metrics: nil, views: layout_dict))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
