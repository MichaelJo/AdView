//
//  TestAutolayoutViewController.swift
//  Test1
//
//  Created by atenca on 2014-08-19.
//  Copyright (c) 2014 atenca. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    let TxtFd = UITextField()
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        //super.init(aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

class UserInfoViewController: UIViewController, UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource,
    UITextFieldDelegate {

    //http://stackoverflow.com/questions/9674685/creating-a-segue-programmatically
    //blurry modal: https://coderwall.com/p/-yka_q
    //https://github.com/bradley/iOSUnwindSegueProgramatically
    let DbgName = "UserInfoView"
    
    var superView : UserListViewController?
    /*
    let NameLabel = UILabel()
    let NameField = UITextField()
    let AccountLabel = UILabel()
    let AccountField = UITextField()
    let PasswordLabel = UILabel()
    let PasswordField = UITextField()

    let SaveButton = UIButton()		
    let CancelButton = UIButton()
	*/
    let Navbar = UINavigationBar()
    let BackgdView = UIImageView()
    
	var TableView: UITableView?
   	let CellIden = "Cell"
    
    override func viewDidLoad() {
        println("\(DbgName) viewDidLoad")    
	    super.viewDidLoad()
    
        //view.backgroundColor = UIColor.whiteColor()
		//SubviewMake()
		//LayoutMake()
        
        NavbarSet()
		TableSet()
		LayoutSet()
    }    
        //http://iphonedev.tv/blog/2014/1/22/programmatic-uibutton-on-ios-70-create-a-uibutton-with-code
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
        backButton.setTitle("  Back ", forState: UIControlState.Normal);
        backButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal);    
        backButton.sizeToFit()    
        backButton.addTarget(self, action: "BackAct:", forControlEvents: UIControlEvents.TouchUpInside);
        let backItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backItem //navigationItem.backBarButtonItem

        let rightBkgd = UIImage(named: "BarButtonImage")!.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6), resizingMode: .Stretch)
        let rightButton = UIButton() //UIButton.buttonWithType(.Custom) as UIButton
        rightButton.setBackgroundImage(rightBkgd, forState:UIControlState.Normal);
        rightButton.setTitle(UserViewDataButton, forState: UIControlState.Normal);
        rightButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal);    
        rightButton.sizeToFit()    
        rightButton.addTarget(self, action: "SaveAct:", forControlEvents: UIControlEvents.TouchUpInside);
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
        self.TableView!.registerClass(UserInfoCell.self, forCellReuseIdentifier: CellIden)  
        
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

        
    /*
	func SubviewMake(){
	
        //22113815-Width-of-uilabel-created-programmatically
        //NameLabel  = UILabel()
        //NameLabel!.backgroundColor = UIColor.grayColor()
        NameLabel.textColor = UIColor.greenColor()
        NameLabel.textAlignment = .Left //NSTextAlignment.
        NameLabel.text = "Screen Name:"
        self.view.addSubview(NameLabel)
        
        //NameField = UITextField()
		NameField.placeholder = "Screen Name"
		NameField.text = UserViewDataName
        NameField.backgroundColor = UIColor.whiteColor()
        NameField.textColor = UIColor.blueColor()
        NameField.borderStyle = UITextBorderStyle.RoundedRect
        NameField.textAlignment = NSTextAlignment.Left
		NameField.keyboardType = UIKeyboardType.Default
        self.view.addSubview(NameField)
        
        //AccountLabel  = UILabel()
        //AccountLabel.backgroundColor = UIColor.grayColor()
        AccountLabel.textColor = UIColor.greenColor()
        AccountLabel.textAlignment = NSTextAlignment.Left 
        AccountLabel.text = "Account:"
        self.view.addSubview(AccountLabel)

        //AccountField = UITextField()
        AccountField.placeholder = "01234567"
		AccountField.text = UserViewDataAccount
        AccountField.backgroundColor = UIColor.whiteColor()
        AccountField.textColor = UIColor.blueColor()
        AccountField.borderStyle = UITextBorderStyle.RoundedRect
        AccountField.textAlignment = .Left //NSTextAlignment
        AccountField.keyboardType = UIKeyboardType.NumberPad
        self.view.addSubview(AccountField)

		//PasswordLabel  = UILabel()
        //PasswordLabel.backgroundColor = UIColor.grayColor()
        PasswordLabel.textColor = UIColor.greenColor()
        PasswordLabel.textAlignment = .Left //NSTextAlignment.
        PasswordLabel.text = "Password:"
        self.view.addSubview(PasswordLabel)

        //PasswordField = UITextField()
        PasswordField.placeholder = "password123"
		PasswordField.text = UserViewDataPassword
        PasswordField.backgroundColor = UIColor.whiteColor()
        PasswordField.textColor = UIColor.blueColor()
        PasswordField.borderStyle = UITextBorderStyle.RoundedRect
        PasswordField.textAlignment = .Left //NSTextAlignment
        PasswordField.keyboardType = UIKeyboardType.Default
		PasswordField.secureTextEntry = true
        self.view.addSubview(PasswordField)
 
		//SaveButton = UIButton()
        SaveButton.frame = CGRectMake(100, 100, 100, 50)
        SaveButton.backgroundColor = UIColor.whiteColor()
		SaveButton.layer.cornerRadius = 8;
		SaveButton.layer.borderWidth = 1;
		SaveButton.layer.borderColor = UIColor.blueColor().CGColor;
		SaveButton.layer.masksToBounds = true;
		//SaveButton.clipsToBounds = true;
        SaveButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal )
        SaveButton.setTitle(UserViewDataButton, forState: UIControlState.Normal)
		SaveButton.sizeToFit()	
        SaveButton.addTarget(self, action: "SaveButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(SaveButton)

        //CancelButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
		//CancelButton = UIButton()
        CancelButton.frame = CGRectMake(100, 100, 100, 50)
        CancelButton.backgroundColor = UIColor.whiteColor()
		CancelButton.layer.cornerRadius = 8;
		CancelButton.layer.borderWidth = 1;
		CancelButton.layer.borderColor = UIColor.grayColor().CGColor;
		CancelButton.clipsToBounds = true;
        CancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal                                                        )		
        CancelButton.setTitle(" Cancel ", forState: UIControlState.Normal)		
		CancelButton.sizeToFit()	
        CancelButton.addTarget(self, action: "CancelButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(CancelButton)
	}
	
	func LayoutMake(){
        //http://blog.ikiapps.com/post/91024428050/making-auto-layout-constraints-more-like-math-in-swift		
		
		NameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
		NameField.setTranslatesAutoresizingMaskIntoConstraints(false)
        AccountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)		
		AccountField.setTranslatesAutoresizingMaskIntoConstraints(false)		
        PasswordLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
		PasswordField.setTranslatesAutoresizingMaskIntoConstraints(false)
		SaveButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        CancelButton.setTranslatesAutoresizingMaskIntoConstraints(false)
		
        //ssNSLayoutConstraint.deactivateConstraints(self.view.constraints())
		//X1
        self.view.addConstraint(NSLayoutConstraint(
            item:self.NameLabel, attribute:.Right, relatedBy:.Equal,
            toItem:self.view, attribute:.CenterX, multiplier:1, constant:-20))
        self.view.addConstraint(NSLayoutConstraint(
            item:self.AccountLabel, attribute:.Right, relatedBy:.Equal,
            toItem:self.NameLabel,attribute:.Right, multiplier:1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:self.PasswordLabel, attribute:.Right, relatedBy:.Equal,
            toItem:self.AccountLabel,attribute:.Right, multiplier:1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:self.SaveButton, attribute:.Right, relatedBy:.Equal,
            toItem:self.AccountLabel,attribute:.Right, multiplier:1, constant:-20))
		//X2
		self.view.addConstraint(NSLayoutConstraint(
            item:self.NameField, attribute:.Left, relatedBy:.Equal,
            toItem:self.view, attribute:.CenterX, multiplier:1, constant:20))
        self.view.addConstraint(NSLayoutConstraint(
            item:self.AccountField, attribute:.Left, relatedBy:.Equal,
            toItem:self.NameField, attribute:.Left, multiplier:1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:self.PasswordField, attribute:.Left, relatedBy:.Equal,
            toItem:self.AccountField, attribute:.Left, multiplier:1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:self.CancelButton, attribute:.Left, relatedBy:.Equal,
            toItem:self.PasswordField,attribute:.Left, multiplier:1, constant:20))
        //Y1        
        self.view.addConstraint(NSLayoutConstraint(
            item:self.NameLabel, attribute:.CenterY, relatedBy:.Equal,
            toItem:self.view, attribute:.Top, multiplier:1, constant:40))
        self.view.addConstraint(NSLayoutConstraint(
            item:self.AccountLabel, attribute:.CenterY, relatedBy:.Equal, 
			toItem:self.NameLabel, attribute:.CenterY, multiplier:1, constant:40))
        self.view.addConstraint(NSLayoutConstraint(
            item:self.PasswordLabel, attribute:.CenterY, relatedBy:.Equal, 
			toItem:self.AccountLabel, attribute:.CenterY, multiplier:1, constant:40))
        self.view.addConstraint(NSLayoutConstraint(
            item:self.SaveButton, attribute:.CenterY, relatedBy:.Equal,
            toItem:self.PasswordLabel,attribute:.CenterY, multiplier:1, constant:60))
		//Y2
		self.view.addConstraint(NSLayoutConstraint(
            item:self.NameField, attribute:.CenterY, relatedBy:.Equal,
            toItem:self.NameLabel, attribute:.CenterY, multiplier:1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:self.AccountField, attribute:.CenterY, relatedBy:.Equal,
            toItem:self.AccountLabel, attribute:.CenterY, multiplier:1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:self.PasswordField, attribute:.CenterY, relatedBy:.Equal,
            toItem:self.PasswordLabel, attribute:.CenterY, multiplier:1, constant:0))
        self.view.addConstraint(NSLayoutConstraint(
            item:self.CancelButton, attribute:.CenterY, relatedBy:.Equal,
            toItem:self.SaveButton,attribute:.CenterY, multiplier:1, constant:0))
    }
    */
//----------------------------------------------------------------------------
	func numberOfSectionsInTableView(tableView: UITableView) -> Int{
    
	    println("\(DbgName) numberOfSectionsInTableView")
		return 1
	}
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
	
		println("\(DbgName) numberOfRowsInSection")
        return 3
    }  
    //Each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{  
        
        let sec = indexPath.section 
		let row = indexPath.row
		println("\(DbgName) cellForRowAtIndexPath sec=\(sec),row=\(row)")
        var cell: UserInfoCell!
        cell = tableView.dequeueReusableCellWithIdentifier(CellIden, forIndexPath:indexPath) as! UserInfoCell

        //cell.TxtFd.autocorrectionType = UITextAutocorrectionTypeNo ;
        //cell.TxtFd.autocapitalizationType = UITextAutocapitalizationTypeNone;
        cell.TxtFd.adjustsFontSizeToFitWidth = true;
        cell.TxtFd.textColor = UIColor(red: 56.0/255.0, green: 84.0/255.0, blue: 135.0/255.0, alpha: 1.0); 
        cell.TxtFd.tag = row; 
        switch row{
        case 0:
            cell.textLabel!.text = "Screen Name:"

            cell.TxtFd.placeholder = "Screen Name" ;        
            cell.TxtFd.text = UserViewDataName ;                     
        case 1:
            cell.textLabel!.text = "Account:"
            
            cell.TxtFd.placeholder = "12345678";        
            cell.TxtFd.text = UserViewDataAccount ;                     
        default:
            cell.textLabel!.text = "Password:"
            
            cell.TxtFd.placeholder = "password";        
            cell.TxtFd.text = UserViewDataPassword ;                     
        }
    
        cell.TxtFd.frame = CGRectMake(160, 8, 170, 30);
	    // Workaround to dismiss keyboard when Done/Return is tapped
        cell.TxtFd.addTarget(self, action: "textFieldFinished:", forControlEvents: UIControlEvents.EditingDidEndOnExit);	
		// We want to handle textFieldDidEndEditing
        cell.TxtFd.delegate = self 
        cell.addSubview(cell.TxtFd)
        
        cell.contentView.backgroundColor = UIColor.clearColor();
        cell.backgroundColor = UIColor.clearColor();
        let bgView = UIView();
        bgView.layer.cornerRadius = 10.0;
        bgView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha:0.7);
        cell.backgroundView = bgView;

		return cell
  
    }  
//----------------------------------------------------------------------------
    // Textfield value changed, store the new value.
    func textFieldDidEndEditing(txtFd: UITextField) {
    
        switch txtFd.tag {
        case 0:
            UserViewDataName = txtFd.text ;                     
        case 1:
            UserViewDataAccount = txtFd.text ;                       
        default:
            UserViewDataPassword = txtFd.text ;                       
        }
	}    
    func BackAct(sender:UIButton!)
    {
        println("\(DbgName) BackAction")
		UserViewDataResult = 0		
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    func SaveAct(sender:UIButton!)
    {
        println("\(DbgName) SaveAction")
        /*
		UserViewDataName = NameField.text
		UserViewDataAccount = AccountField.text		
		UserViewDataPassword = PasswordField.text				
        */
		UserViewDataResult = 1
		self.dismissViewControllerAnimated(true, completion: nil);
    }
	
	override func viewDidDisappear(animated: Bool){
		println("\(DbgName) viewWillDisappear")
		super.viewWillDisappear(animated)

        superView!.UserInfoViewEnd()
	}    
}
