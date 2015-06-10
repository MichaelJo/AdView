//
//  UserListViewController.swift

import UIKit

class UserCell0: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        //super.init(aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
class UserCell1 : UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        //super.init(aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
 }
//----------------------------------------------------------------------------    
class UserListViewController: UIViewController, UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate {

    let DbgName = "UserListView"
	
    let Navbar = UINavigationBar()
    let BackgdView = UIImageView()
    
    let HeaderH = CGFloat(30.00)
    let FooterH = CGFloat(50.00)
	var TableView: UITableView?
   	let Cell0Iden = "Cell0"
   	let Cell1Iden = "Cell1"    
    var UserStateShow = ""
    var PopoverView: UIView?
    var PopoverRect:  CGRect?
    
    override func viewDidLoad() {
        //var context = SDSyncEngine.sharedEngine().managedObjectContext()!
        /*var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        
        newUser.setValue("Alex Song", forKey: "username")
        newUser.setValue("1234cc", forKey: "password")
        
        context.save(nil)
        */
        //var cdrequest = NSFetchRequest(entityName: "Holiday")
        //cdrequest.returnsObjectsAsFaults = false
        //var error: NSError?
        
        //var results = context.executeFetchRequest(cdrequest, error: &error);
        var cdb = CoreDataBase()
        
        //println(error)
        //println(results)
        /*
        var context = SDSyncEngine.sharedEngine().managedObjectContext()!
        /*var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        
        newUser.setValue("Alex Song", forKey: "username")
        newUser.setValue("1234cc", forKey: "password")
        
        context.save(nil)
        */
        var cdrequest = NSFetchRequest(entityName: "Holiday")
        cdrequest.returnsObjectsAsFaults = false
        var error: NSError?
        
        var results = context.executeFetchRequest(cdrequest, error: &error);
        println(error)
        println(results)
        */
        super.viewDidLoad()

		UserViewDataIdx = -1
        //view.backgroundColor = UIColor.whiteColor()
		
        NavbarSet()
		TableSet()
		LayoutSet()

        let Timer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("TimerUpdate"), userInfo: nil, repeats: true)		
    }
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//----------------------------------------------------------------------------    	
    func positionForBar(bar: UIBarPositioning!) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
    func NavbarSet(){
    
        //Zorder=0
        let image = UIImage(named: "BgImage")!.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .Stretch)
        BackgdView.image = image;
        self.view.addSubview(BackgdView)
        //self.view.sendSubviewToBack(BackgdView)
        
        Navbar.translucent = false
        Navbar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "User List"
        
        // Create left and right button for navigation item
        let backBkgd = UIImage(named: "BarBackImage")!.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 6), resizingMode: .Stretch)
        let backButton = UIButton() 
        backButton.setBackgroundImage(backBkgd, forState:UIControlState.Normal);
        backButton.setTitle("  Main ", forState: UIControlState.Normal);
        backButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal);    
        backButton.sizeToFit()    
        backButton.addTarget(self, action: "BackAct:", forControlEvents: UIControlEvents.TouchUpInside);
        let backItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backItem //navigationItem.backBarButtonItem

        let rightBkgd = UIImage(named: "BarButtonImage")!.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6), resizingMode: .Stretch)
        let rightButton = UIButton() //UIButton.buttonWithType(.Custom) as UIButton
        rightButton.setBackgroundImage(rightBkgd, forState:UIControlState.Normal);
        rightButton.setTitle(" Add ", forState: UIControlState.Normal);
        rightButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal);    
        rightButton.sizeToFit()    
        rightButton.addTarget(self, action: "AddAct:", forControlEvents: UIControlEvents.TouchUpInside);
        let rightItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightItem
        
        Navbar.items = [navigationItem]
        //Navbar.sizeToFit()
        self.view.addSubview(Navbar)
    }
	func TableSet(){
        
		self.TableView = UITableView(frame:self.view.frame, style:UITableViewStyle.Plain)  
        self.TableView!.dataSource = self  
        self.TableView!.delegate = self  
        self.TableView!.registerClass(UserCell0.self, forCellReuseIdentifier: Cell0Iden)  
        self.TableView!.registerClass(UserCell1.self, forCellReuseIdentifier: Cell1Iden)          
        
        //TableView!.sectionHeaderHeight = 32.00 
        //BackgdView.frame = self.view.frame;
        //let image = UIImage(named: "BgImage")
        //BackgdView.image = image;
        //self.TableView!.backgroundView = BackgdView  //if nil bgcolor works.
        self.TableView!.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha:0.7);
        //self.TableView!.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.TableView!)  
	}
	func LayoutSet(){	
	
		var layout_dict = Dictionary <String, UIView>()
		layout_dict["Navbar"] = Navbar 
		Navbar.setTranslatesAutoresizingMaskIntoConstraints(false)
		layout_dict["TableView"] = TableView! 
		TableView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["BackgdView"] = BackgdView 
		BackgdView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //NSLayoutConstraint.deactivateConstraints(self.view.constraints())
		
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
			"V:|-20-[Navbar][TableView]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
			"H:|-0-[Navbar]-0-|", options: nil, metrics: nil, views: layout_dict))	
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
			"H:|-0-[TableView]-0-|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[Navbar][BackgdView]|", options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[BackgdView]-0-|", options: nil, metrics: nil, views: layout_dict))
	}
//----------------------------------------------------------------------------
    func BackAct(sender: AnyObject)
    {
        println("\(DbgName) BackAct")
        //[self.navigationController popViewControllerAnimated:YES];
        self.navigationController?.popViewControllerAnimated(true)
        //self.dismissViewControllerAnimated(true, completion: nil);
    }
    func AddAct(sender: AnyObject)
    {
        println("\(DbgName) AddAct")
        AddAction();
    }
    func ShowMenu()
    {
        println("\(DbgName) ShowMenu")    
        let Device = UIDevice.currentDevice()
        let iosVersion = NSString(string: Device.systemVersion).doubleValue
        //let iOS8 = iosVersion >= 8
        let iOS7 = iosVersion >= 7 && iosVersion < 8
        if (iOS7){
            ShowMenu7()
        }
        else{
            ShowMenu8()
        }
    }
    func ShowMenu7(){
        println("\(DbgName) ShowMenu7")

        var msg = "Login anonymously?"
        if (UserViewDataIdx > 0){
            msg = "What to do with the selected?"
        }
        let actionSheet = UIActionSheet(title: msg, delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil)

        var cnt = 0
        if (UserViewDataIdx > 0){
            actionSheet.addButtonWithTitle("Delete");
            actionSheet.destructiveButtonIndex = cnt;
            cnt++;
        }
        actionSheet.addButtonWithTitle("Login");
        //actionSheet.firstOtherButtonIndex = cnt;
        cnt++;
        if (UserViewDataIdx > 0){
            actionSheet.addButtonWithTitle("Edit");
            cnt++;
        }
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
        MenuAct(name)
    }
    func ShowMenu8() {
    
        var msg = "Login anonymously?"
        if (UserViewDataIdx > 0){
            msg = "What to do with the selected?"
        }
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .ActionSheet)
        
        if (UserViewDataIdx > 0){
            let delAction = UIAlertAction(title: "Delete", style: .Destructive, handler: Menu8Act)
            alertController.addAction(delAction)
        }         
        let loginAction = UIAlertAction(title: "Login", style: .Default, handler: Menu8Act)
        alertController.addAction(loginAction)
        if (UserViewDataIdx > 0){
            let editAction = UIAlertAction(title: "Edit", style: .Default, handler: Menu8Act)
            alertController.addAction(editAction)
        }
        if (isIphone()){
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: Menu8Act)
            alertController.addAction(cancelAction)
        }
        else{
            alertController.popoverPresentationController!.sourceView = PopoverView! //self.view;
            alertController.popoverPresentationController!.sourceRect = PopoverRect!
        }
        //[popOverController presentPopoverFromRect:rect inView:cell permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    func Menu8Act(action: UIAlertAction!){
    
        println("\(DbgName) Menu8Act name=\(action.title)")
        MenuAct(action.title)
    }
    func MenuAct(name: String){
        println("\(DbgName) MenuAct name=\(name)")
        
        switch name {
        case "Login":
            LoginAction();
            break;
        case "Edit":
            EditAction();
            break;
        case "Delete":
            DelAction();
            break;
        default:
            break;
        }
    }
	func TimerUpdate() {
	
	    if (UserStateShow == UserState){
			return
		}
        UserStateShow = UserState
        TableView!.reloadData()	
        //tableView!.reloadSections(NSIndexSet(index: sec),withRowAnimation: UITableViewRowAnimation.Left)
    }
//----------------------------------------------------------------------------    
	func UserInfoViewBegin(act_str: String)
    {
	    UserViewDataAct = act_str
		let info_view = UserInfoViewController()
        info_view.superView = self
		info_view.modalPresentationStyle = UIModalPresentationStyle.FullScreen //FormSheet
		//report_view.modalTransitionStyle = 
		self.presentViewController(info_view, animated: true, completion: nil)
		//performSegueWithIdentifier("UserList2UserDataSegue", sender: self);
        //self.dismissViewControllerAnimated(true, completion: nil);
	}
	func AddAction()
    {
        println("\(DbgName) AddAction")	
		UserViewDataName = ""		
		UserViewDataAccount = ""				
		UserViewDataPassword = ""						
		UserViewDataButton = " Add "

		UserInfoViewBegin("Add")
    }
	func EditAction()
    {
        println("\(DbgName) EditAction")	
		UserViewDataName = UserAry[UserViewDataIdx].Name		
		UserViewDataAccount = UserAry[UserViewDataIdx].Account			
		UserViewDataPassword = UserAry[UserViewDataIdx].Password						
		UserViewDataButton = " Save "

		UserInfoViewBegin("Edit")
    }
	func DelAction()
    {
        println("\(DbgName) DelAction")	
		UserViewDataName = UserAry[UserViewDataIdx].Name		
		UserViewDataAccount = UserAry[UserViewDataIdx].Account			
		UserViewDataPassword = UserAry[UserViewDataIdx].Password						
		UserViewDataButton = " Delete "								

		UserInfoViewBegin("Del")
    }
	func LoginAction()
    {
        println("\(DbgName) LoginAction")	    
		if  UserState == "Login..." {
			let alert = UIAlertView(title: "Alert", message: "Sorry, we are still trying the last login.", 
				delegate: nil, cancelButtonTitle: "OK")
			alert.show()
			return
		}
        
        UserIdx = UserViewDataIdx
		UserAccountSetting().UserListDataLogin(UserIdx)
        
        UserStateShow = ""
        TimerUpdate()
        //TableView!.reloadSections(NSIndexSet(index: 0),withRowAnimation: UITableViewRowAnimation.Left)
    }
	func UserInfoViewEnd()
    {
		if (UserViewDataResult == 0){
			return
		}
        var ua = UserAccountSetting()
		switch (UserViewDataAct){
		case "Add":
			ua.UserListDataAdd(UserViewDataName,account: UserViewDataAccount,password: UserViewDataPassword)
		case "Edit":
			ua.UserListDataEdit(UserViewDataIdx,name: UserViewDataName,account: UserViewDataAccount,password: UserViewDataPassword)
		case "Del":
			ua.UserListDataDel(UserViewDataIdx)
		default:
		    return
		}
		
		if (UserViewDataIdx >= UserAry.count){
		    UserViewDataIdx = -1
		}
		//UserStateShow = ""
		TableView!.reloadData()			
	}
//----------------------------------------------------------------------------
	func numberOfSectionsInTableView(tableView: UITableView) -> Int{
    
	    println("\(DbgName) numberOfSectionsInTableView")
		return 2
	}
    //When we return UIView, shoud not use titleForHeaderInSection
	//func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
    //When we return UIView, must still use heightForHeaderInSection
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
    
    	println("\(DbgName) heightForHeaderInSection sec=\(section)")
		switch section{
		case 0:
		    return 00.01 //0.00 = default
		default:
			return HeaderH
		}
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        println("\(DbgName) viewForHeaderInSection sec=\(section)")
        if (section == 0){
            return nil
        }
        
        let view_rect = CGRectMake(0, 0, tableView.frame.size.width, HeaderH)
        let view = UIView(frame: view_rect)
        view.backgroundColor = UIColor.clearColor();
        
        let label_rect = CGRectMake(0, 5, tableView.frame.size.width, 25.0)
        let label = UILabel(frame: label_rect)
        label.backgroundColor = UIColor.clearColor();
        label.textAlignment = NSTextAlignment.Center;
        label.font = UIFont.systemFontOfSize(20.0);
        view.addSubview(label);                
        switch (section) {
        case 0:
            label.text = "Login State";
        default:
            label.text = "Account List";
        }

        return view;            
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
    
    	println("\(DbgName) heightForFootInSection sec=\(section)")
		switch section{
		case 0:
		    return 00.01 //0.00 = default
		default:
			return FooterH
		}
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        println("\(DbgName) viewForFooterInSection sec=\(section)")
        if (section == 0){
            return nil
        }
        
        let view_rect = CGRectMake(0, 0, tableView.frame.size.width, FooterH)
        let view = UIView(frame: view_rect)
        view.backgroundColor = UIColor.clearColor();
        
        let label_rect = CGRectMake(10, 0, tableView.frame.size.width-10, FooterH)
        let label = UILabel(frame: label_rect)
        label.numberOfLines = 0;
        label.lineBreakMode = .ByWordWrapping
        label.textAlignment = NSTextAlignment.Left;
        label.text = "Guest account is for you to login anonymously.\n"
         + "Please first add your real account and tap it to login.\n"
         + "You can also tap to edit/delete any account except Guest."        
        label.font = UIFont.systemFontOfSize(10.0);
        label.textColor = UIColor.grayColor()
        label.backgroundColor = UIColor.clearColor();
        view.addSubview(label);                

        return view;            
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
	
		println("\(DbgName) numberOfRowsInSection")
		switch section {
		case 0: 
            return 2
		default: 
            return UserAry.count;
		}
    }  
    //Each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{  
        
        let sec = indexPath.section 
		let row = indexPath.row
		println("\(DbgName) cellForRowAtIndexPath sec=\(sec),row=\(row)")
        var cell: UITableViewCell!
        switch sec {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(Cell0Iden, forIndexPath:indexPath) as! UserCell0
            switch row{
            case 0:
                cell.textLabel!.text = "Screen Name:"
                cell.detailTextLabel!.text = UserAry[UserIdx].Name 
            default:
                cell.textLabel!.text = "Login state:"
                cell.detailTextLabel!.text = UserState
                let label = cell.detailTextLabel!
           		switch UserState {
                case "None":
                    label.textColor = UIColor.grayColor()
                case "Login...":
                    label.textColor = UIColor.yellowColor()
                case "Okay":
                    label.textColor = UIColor.greenColor()
                case "Failed":
                    label.textColor = UIColor.orangeColor()
                case "Error":
                    label.textColor = UIColor.redColor()
                default:
                    label.textColor = UIColor.blueColor()
                }

                UserStateShow = UserState
            }
        default:
            cell = tableView.dequeueReusableCellWithIdentifier(Cell1Iden, forIndexPath:indexPath) as! UserCell1        
            cell.textLabel!.text = UserAry[row].Name
            cell.detailTextLabel!.text = UserAry[indexPath.row].Account
            if (indexPath.row == UserIdx){			
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        }

        cell.contentView.backgroundColor = UIColor.clearColor();
        cell.backgroundColor = UIColor.clearColor();
        let bgView = UIView();
        if (sec > 0) {
            bgView.layer.cornerRadius = 10.0;
        }
        bgView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha:0.7);
        cell.backgroundView = bgView;

		return cell
  
    }  
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){ 
		println("\(DbgName) didSelectRowAtIndexPath")
		let sec = indexPath.section 
		if (sec==0){
			return
		}
		let row = indexPath.row		
        UserViewDataIdx = row
        
        let cell = tableView.cellForRowAtIndexPath(indexPath);
        PopoverView = cell!.contentView
        PopoverRect = CGRectMake(cell!.bounds.origin.x+400, cell!.bounds.origin.y+10, 50, 30);
        ShowMenu()
    }
	func tableView(tableView: UITableView,didDeselectRowAtIndexPath indexPath: NSIndexPath){
		println("\(DbgName) didDeselectRowAtIndexPath")
		UserViewDataIdx = -1
    }  
}
/*
There are two ways to set a background image to a UIView –
You can set your view background color to color created with UIColor’s colorWithPaternImage.
You can add a UIImageView subview to your view.

http://stackoverflow.com/questions/24172605/uiactionsheet-with-swift

[tv beginUpdates];
    [tv insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
    [tv deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [tv endUpdates];
*/