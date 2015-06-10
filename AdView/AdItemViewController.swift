//
//  AdItemViewController.swift
//  AdView
//
//  Created by DavidWu on 2014-08-04.
//  Copyright (c) 2014 AditMax. All rights reserved.
//

import UIKit
import MessageUI

class AdItemViewController: UIViewController, UINavigationBarDelegate, UIWebViewDelegate, MFMailComposeViewControllerDelegate, UIActionSheetDelegate,AdRateDelegate,ServerManagerDelegate {
    
//    let rate_view = AdModeViewController()
    var DbgName = "AdItemView"
    let CountDown = 20
    let Navbar = UINavigationBar()
    //let Toolbar = UIToolbar() as UIToolbar
    let AdsFld = UITextField() as UITextField
    let StatFld = UITextField() as UITextField
    var WebView: UIWebView?
    var adsViewed = 0
    var WebOn = 0
    var WebCnt0 = 0
    var WebCnt1 = 0
    var IdStr = "0083532"    
    var UrlStr = "http://yahoo.ca"
    var dateString: String = ""
 
    func adsListLoaded(error: String, adsViewed: Int) {
        
    }

    func loginFailed(error: String) {
        
    }
    func ratingSubmitted(error: String, adsViewed: Int){
    }
    func rateButtonClicked(controller: AdRateViewController, error: String, count: Int) {
        if(error == ""){
            //AdsViewed = count
            AdsFld.text = "Ads viewed: \(count)"
        }else{
            let actionSheetController: UIAlertController = UIAlertController(title: "Alert", message: error, preferredStyle: .Alert)
            //Create and an option action
            let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
                //Do some other stuff
            }
            actionSheetController.addAction(nextAction)
            //Present the AlertController
            self.presentViewController(actionSheetController, animated: true, completion: nil)
        }
        
    }
    func UrlSet(step: Int) {
        
        AdListSetIdx(step)
        UrlStr = AdListGetUrl(CellIdx)
        IdStr = String(CellAry[CellIdx].AdId)
        AdListPreload()
        
        println("\(DbgName) UrlSet idx=\(CellIdx) str=\(UrlStr)")
        //if (CellIdx == 0){
        //    UrlStr = "http://user.99114.com/629068/contact.html"
            //UrlStr = "http://photo.blog.sina.com.cn/u/3728518791"
        //}
        
        //Load webview
        WebView!.stopLoading()
        
        let url0 = NSURL(string: "about:blank")
        let request0 = NSURLRequest(URL: url0!)
        WebView!.loadRequest(request0)
    
        let url = NSURL(string: UrlStr)
        let request = NSURLRequest(URL: url!)
        WebView!.loadRequest(request)
        
        StatFld.text = "Loading"
        TimerStat = ""
        WebOn = 1
        WebCnt0 = 0
        WebCnt1 = 0
    }
    
    enum TActEnum: Int{
        case None = 0
        case Rewind = 1, Forward, GotoList
        func ToStr() -> String {
            switch self{
            case .None:
                return "None"
            case .Rewind:
                return "Rewind"
            case .Forward:
                return "Forward"
            case .GotoList:
                return "GotoList"
            default:
                return "Known"
            }
        }
    }
    var ActEnum = TActEnum.None
    func ActExec(){
        println("\(DbgName) ActExec act=\(ActEnum.ToStr())")
        switch ActEnum{
        case TActEnum.GotoList:
            self.dismissViewControllerAnimated(true, completion: nil);
            //self.performSegueWithIdentifier("unwindToAdListSegue", sender: self)
        case TActEnum.Forward:
            UrlSet(1);
        case TActEnum.Rewind:
            UrlSet(-1);
        default:
            println("\(DbgName) ActExec error!")
        }
    }

    var Timer = NSTimer()
    var TimerCnt = 0
    var TimerStat = ""
    func TimerUpdate() {

        if (WebOn==0){
            return
        }
        
        switch TimerStat{
        case "Counting":
            TimerCnt--;
            if (TimerCnt > 0) {
                StatFld.text = "Count: \(TimerCnt)"
                return
            }
            TimerStat = "Counted"
            RateAct(self)
        case "Pasued":
            return
        default:
            if (WebView!.loading){
                StatFld.text = "Loading"
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            }
            else{
                StatFld.text = "Loaded"
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        }
    }
    //TimerAlert
    var TimerAlertTitle = "Warning: "
    var TimerAlertMsg0 = "There are still"
    var TimerAlertMsg1 = "seconds left before you can get the full points."
    var TimerAlertStr0 = "Leave"
    var TimerAlertStr1 = "Stay"
    func TimerAlert(act: TActEnum) -> Bool {
        ActEnum = act
        if (TimerStat == "Counted" || TimerCnt < 1){
            return false
        }
        println("\(DbgName) TimerAlert=\(TimerCnt)")
       
        var alert: UIAlertView = UIAlertView()
        alert.title = TimerAlertTitle
        alert.message = "\(TimerAlertMsg0) \(TimerCnt) \(TimerAlertMsg1)"
        alert.addButtonWithTitle(TimerAlertStr0)
        alert.addButtonWithTitle(TimerAlertStr1)
        alert.delegate = self
        alert.show()
        
        TimerStat = "Paused"
        return true
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: NSInteger) {
        
        var title = alertView.buttonTitleAtIndex(buttonIndex);
        println("\(DbgName) AlertBtn=\(title)")
        
        if (title == "Stay") {
            TimerStat = "Counting"
            return
        }
        //Timer.invalidate();
        ActExec()
    }
    
    //Timer/ToList
    func ListAct(sender: AnyObject){
        println("\(DbgName) Back to AdListView")
        if (TimerAlert(TActEnum.GotoList)){
            return
        }
        ActExec()
    }
//-------------------------------------------------------------------------------------    
    func RateAct(sender: AnyObject) {
        println("\(DbgName) Goto RateView")
        
        let rate_view = AdRateViewController()
        rate_view.AdId = IdStr
        rate_view.StartDateString = self.dateString
		rate_view.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        rate_view.delegate = self
		//rate_view.modalTransitionStyle = 
		self.presentViewController(rate_view, animated: true, completion: nil)
    }
    func ReportAct(sender: AnyObject) {
        println("\(DbgName) Goto ReportView")
        let rpt_view = AdReportViewController()
        rpt_view.AdId = IdStr
        rpt_view.AdUrl = UrlStr        
		rpt_view.modalPresentationStyle = UIModalPresentationStyle.FormSheet
		//rpt_view.modalTransitionStyle = 
		self.presentViewController(rpt_view, animated: true, completion: nil)
    }
    func InfoAct(sender: AnyObject) {
        println("\(DbgName) Goto HelpView")
        let help_view = AdItemHelpViewController()
		help_view.modalPresentationStyle = UIModalPresentationStyle.FormSheet
		//help_view.modalTransitionStyle = 
		self.presentViewController(help_view, animated: true, completion: nil)
    }    
    //func ShareAct(sender: AnyObject) {
    func Bar2Menu(sender: AnyObject) {
        println("\(DbgName) Bar2Menu")
        let Device = UIDevice.currentDevice()
        let iosVersion = NSString(string: Device.systemVersion).doubleValue
        //let iOS8 = iosVersion >= 8
        let iOS7 = iosVersion >= 7 && iosVersion < 8
        if (iOS7){
            ActionMenuiOS7()
        }
        else{
            ActionMenuiOS8()
        }
    }
    func GoLastAct(sender: AnyObject) {
        println("\(DbgName) Goto last Ad timecnt=\(TimerCnt)")
        if (TimerAlert(TActEnum.Rewind)){
            return
        }
        ActExec()
    }
    func GoNextAct(sender: AnyObject) {
        println("\(DbgName) Goto next Ad timecnt=\(TimerCnt)")
        if (TimerAlert(TActEnum.Forward)){
            return
        }
        ActExec()
    }
//----------------------------------------------------------------------------        
        //@IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        println("\(DbgName) viewDidLoad")
        super.viewDidLoad()

        
        //ToolbarSet()
        NavbarSet()
        StatInfoSet()
        WebViewSet()
        LayoutSet()

            let date = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            formatter.timeZone = NSTimeZone(name: "America/Vancouver")
            dateString = formatter.stringFromDate(date)
            
        //WebView.stringByEvaluatingJavaScriptFromString("document.body.innerHTML = \"\";")
        //20 sec count down
        UrlSet(0)
        Timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("TimerUpdate"), userInfo: nil, repeats: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func positionForBar(bar: UIBarPositioning!) -> UIBarPosition {
        return UIBarPosition.TopAttached
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
        backButton.setBackgroundImage(backBkgd, forState:UIControlState.Normal);
        backButton.setTitle("  List ", forState: UIControlState.Normal);
        backButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal);
        backButton.sizeToFit()
        backButton.addTarget(self, action: "ListAct:", forControlEvents: UIControlEvents.TouchUpInside);
        let backItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backItem //navigationItem.backBarButtonItem
        
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
    func StatInfoSet(){
        
        AdsFld.text = "Ads viewed: \(self.adsViewed)"
        AdsFld.sizeToFit()
        AdsFld.backgroundColor = UIColor.grayColor()
        AdsFld.textColor = UIColor.greenColor()
        AdsFld.borderStyle = UITextBorderStyle.RoundedRect
        AdsFld.enabled = false
        self.view.addSubview(AdsFld)
        
        StatFld.placeholder = "Loading"
        StatFld.sizeToFit()
        StatFld.backgroundColor = UIColor.grayColor()
        StatFld.textColor = UIColor.blueColor()
        StatFld.borderStyle = UITextBorderStyle.RoundedRect
        StatFld.enabled = false
        self.view.addSubview(StatFld)
    }
    func WebViewSet() {
        
        WebView = UIWebView(frame: self.view.frame) as UIWebView
        let LeftSelector : Selector = "GesSwipeLeft:"
        let SwipeToLeft = UISwipeGestureRecognizer(target: self, action: LeftSelector)
        SwipeToLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(SwipeToLeft)
        WebView!.scrollView.panGestureRecognizer.requireGestureRecognizerToFail(SwipeToLeft);
        let RightSelector : Selector = "GesSwipeRight:"
        let SwipeToRight = UISwipeGestureRecognizer(target: self, action: RightSelector)
        SwipeToRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(SwipeToRight)
        WebView!.scrollView.panGestureRecognizer.requireGestureRecognizerToFail(SwipeToRight);
        
        if (AdModeShrink==1){
            WebView!.scalesPageToFit = true
        }
        else{
            WebView!.scalesPageToFit = false
        }
        WebView!.delegate = self
        self.view.addSubview(WebView!)
        //WebView.stringByEvaluatingJavaScriptFromString("document.body.innerHTML = \"\";")
    }
    func LayoutSet(){
        
        var layout_dict = Dictionary <String, UIView>()
        layout_dict["Navbar"] = Navbar
        Navbar.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["AdsFld"] = AdsFld
        AdsFld.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["StatFld"] = StatFld
        StatFld.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["WebView"] = WebView!
        WebView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //NSLayoutConstraint.deactivateConstraints(self.view.constraints())
        
        //self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
        //    "V:|-20-[Navbar]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[Navbar]-10-[AdsFld]-10-[WebView]|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[Navbar]-0-|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[AdsFld]-(>=10)-[StatFld]-0-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[WebView]-0-|", options: nil, metrics: nil, views: layout_dict))
    }
//----------------------------------------------------------------------------
   
    func ActionMenuiOS7(){
        println("\(DbgName) ShareMenu7")
        
        var msg = "Choose your action:";
        let actionSheet = UIActionSheet(title: msg, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil)
        
        var cnt = 4;
        //actionSheet.addButtonWithTitle("Rate the ad");
        //cnt++;
        actionSheet.addButtonWithTitle("Share with email");
        //cnt++;
        actionSheet.addButtonWithTitle("Share by WeChat");
        //cnt++;
        //actionSheet.addButtonWithTitle("Report issues");
        //cnt++;
        actionSheet.addButtonWithTitle("Show next ad");
        //cnt++;
        actionSheet.addButtonWithTitle("Back to list");
        //cnt++;
        
        if (isIphone()){
            actionSheet.addButtonWithTitle("Cancel");
            actionSheet.cancelButtonIndex = cnt;
            cnt++;
        }
        
        actionSheet.showInView(self.view)
        //self.dismissViewControllerAnimated(true, completion: nil);
    }
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        println("\(DbgName) actionSheet idx=\(buttonIndex)")
        if (buttonIndex<0){
            return
        }
        
        let name = actionSheet.buttonTitleAtIndex(buttonIndex)
        println("\(DbgName) actionSheet name=\(name)")
        MenuAct(buttonIndex);
    }
    func ActionMenuiOS8() {
        
        var msg = "Choose your action:";
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .ActionSheet)

        //let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
       // ...
       // }
       
        //{ (parameters) -> return type in
        //statements
        //}
        
        //let rateAction = UIAlertAction(title: "Rate the ad", style: .Default, handler: {(action) in self.MenuAct(0)})
        //alertController.addAction(rateAction)
        let emailAction = UIAlertAction(title: "Share with email", style: .Default, handler: {(action) in self.MenuAct(0)})
        alertController.addAction(emailAction)
        let wechatAction = UIAlertAction(title: "Share by WeChat", style: .Default, handler: {(action) in self.MenuAct(1)})
        alertController.addAction(wechatAction)
        //let reportAction = UIAlertAction(title: "Report issues", style: .Default, handler: {(action) in self.MenuAct(3)})
        //alertController.addAction(reportAction)
        let nextAction = UIAlertAction(title: "Show next ad", style: .Default, handler: {(action) in self.MenuAct(2)})
        alertController.addAction(nextAction)
        let listAction = UIAlertAction(title: "Back to list", style: .Default, handler: {(action) in self.MenuAct(3)})
        alertController.addAction(listAction)

        if (isIphone()){
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {(action) in self.MenuAct(4)})
            alertController.addAction(cancelAction)
        }
        else{
            alertController.popoverPresentationController!.sourceView = self.view;
            alertController.popoverPresentationController!.sourceRect =
                CGRectMake(self.view.frame.size.width/2,self.view.frame.size.height/2, 1, 1);
        }
        presentViewController(alertController, animated: true, completion: nil)
    }
    /*
    func Menu8Act(action: UIAlertAction!){
        
        println("\(DbgName) Menu8Act name=\(action.title)")
        MenuAct(action., action.title)
    }*/
    func MenuAct(idx: Int){
        println("\(DbgName) MenuAct idx=\(idx)")

        switch idx {
        //case 0:
        //    RateAct(self);
        //    break;
        case 0:
            ShareEmail();
            break;
        case 1:
            WeChatSendLink(UrlStr);
            break;
        //case 3:
        //    ReportAct(self);
        //    break;
        case 2:
            GoNextAct(self);
            break;
        case 3:
            ListAct(self);
            break;
        default:
            break;
        }

        /*
        switch name {
        case "Email":
            ShareEmail();
            break;
        case "WeChat":
            WeChatSendLink(UrlStr);
            break;
        default:
            break;
        }
        */
    }
    func ShareEmail() {
        println("\(DbgName) ShareEmail")
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["someone@somewhere.com"])
        mailComposerVC.setSubject("Share an Ad...")
        mailComposerVC.setMessageBody("Link is: \n \(UrlStr)", isHTML: false)
        
        return mailComposerVC
    }
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

//----------------------------------------------------------------------------    
    func GesSwipeLeft(gesture : UIGestureRecognizer){
        println("\(DbgName) GesSwipeLeft")
        if (TimerAlert(TActEnum.Rewind)){
            return
        }
        ActExec()
    }
    func GesSwipeRight(gesture : UIGestureRecognizer){
        println("\(DbgName) GesSwipeLeft")
        if (TimerAlert(TActEnum.Forward)){
            return
        }
        ActExec()
    }
//----------------------------------------------------------------------------        
    func webViewDidStartLoad(webView: UIWebView) {
        
        WebCnt0++;
        println("\(DbgName) webViewDidStartLoad \(WebCnt0),\(WebCnt1)")
        
        //StatFld.text = "State: loading"
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        //ActivityIndicator.hidden = false
        //ActivityIndicator.startAnimating()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        if (WebCnt0 == 0){
            return //Left by last loading
        }
        WebCnt1++;
        println("\(DbgName) webViewDidFinishLoad \(WebCnt0),\(WebCnt1)")
        
        //Skip the "about:Blank"
        if (WebCnt0 == WebCnt1) && (WebCnt0 >= 2){
            if (TimerStat == ""){
                TimerCnt = CountDown
                TimerStat = "Counting"
            }
        }
    }
    
    func webView(webView: UIWebView!, didFailLoadWithError error: NSError!) {
        println("\(DbgName) didFailLoadWithError \(webView.request!.URL!.absoluteString) \(error.code)");
        /*
        StatFld.text = "State: err=\(error.code) cnt=\(WebLoadCnt)"
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        WebStat = "error"
        */
        //return
    }
    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebViewNavigationType) -> Bool {
        
        println("\(DbgName) shouldStartLoadWithRequest \(request.URL!.absoluteString)");
        return true
    }
}
