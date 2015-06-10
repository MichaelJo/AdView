//
//  AdModeViewController.swift
//  AdView
//
//  Created by DavidWu on 2014-08-11.
//  Copyright (c) 2014 AditMax. All rights reserved.
//

import UIKit
var AdMode = 0

class AdModeCell : UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AdModeViewController: UIViewController, UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource  {

    var DbgName = "AdModeView"
    
    let Navbar = UINavigationBar()
    let BackgdView = UIImageView()
    
    var TableView: UITableView?
   	let CellIden = "Cell"	
    
//----------------------------------------------------------------------------	    
    override func viewDidLoad() {
        println("\(DbgName) viewDidLoad")
        super.viewDidLoad()

        //view.backgroundColor = UIColor.whiteColor()
		NavbarSet()        
        TableSet()
		LayoutSet()
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
        //BackgdView.frame = self.view.frame;
        let image = UIImage(named: "BgImage")!.resizableImageWithCapInsets(
            UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .Stretch)
        BackgdView.image = image;
        self.view.addSubview(BackgdView)
        //self.view.sendSubviewToBack(BackgdView)
        
        Navbar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Settings"
        
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
        rightButton.setTitle(" Reset ", forState: UIControlState.Normal);
        rightButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal);    
        rightButton.sizeToFit()    
        rightButton.addTarget(self, action: "ResetAct:", forControlEvents: UIControlEvents.TouchUpInside);
        let rightItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightItem
        
        Navbar.items = [navigationItem]
        //Navbar.sizeToFit()
        self.view.addSubview(Navbar)
    }
    func TableSet(){
	    
		self.TableView = UITableView(frame:self.view.frame, style:UITableViewStyle.Grouped)  
        self.TableView!.dataSource = self  
        self.TableView!.delegate = self  
        self.TableView!.registerClass(AdModeCell.classForCoder(), forCellReuseIdentifier: CellIden)  
        self.TableView!.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha:0.7);
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
//        self.dismissViewControllerAnimated(true, completion: nil);
 //       [self.navigationController popViewControllerAnimated:YES];
        self.navigationController?.popViewControllerAnimated(true)
    }
    func ResetAct(sender: AnyObject)
    {
        println("\(DbgName) AddAct")
        
        AdModeShrink = 1
        //AdModeGoNext = 0
        TableView!.reloadData()	        
    }
//----------------------------------------------------------------------------	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int{
	    
		return 1
	}
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
	    return "View Setting"
/*        switch section{
        case 0:
            return "View Setting"
        default:
            return "List Setting"        
        }*/
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        //switch section{
        //case 0:
            return 1
        //default:
        //    return 1
        //}
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("\(DbgName) cellForRowAtIndexPath row=\(indexPath.row)")
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIden, forIndexPath:indexPath) as! AdModeCell		
        cell.accessoryType = UITableViewCellAccessoryType.None
        let sec = indexPath.section
        cell.textLabel!.text = "Shrink web pages to fit."
        /*
        switch(sec){
        case 0:
            cell.textLabel!.text = "Shrink web pages to fit."
        default: 
            cell.textLabel!.text = "Jump to next ad"
            //cell.detailTextLabel!.text = "Automatically go to next Ad"
        }*/
        let onOff = UISwitch()
        onOff.frame = CGRect(x: 0, y: 0, width: 28, height: 28);
        onOff.tag = sec
        var value = true
        if (AdModeShrink == 0){
            value = false
        }

        /*
        switch(sec){
        case 0:
            if (AdModeShrink == 0){
                value = false
            }
        default: 
            if (AdModeGoNext == 0){
                value = false
            }
        }*/
        onOff.setOn(value, animated:false)
        onOff.addTarget(self, action: "OnOffAct:", forControlEvents: UIControlEvents.ValueChanged)
        cell.accessoryView = onOff;
        
        cell.contentView.backgroundColor = UIColor.clearColor();
        cell.backgroundColor = UIColor.clearColor();
        let bgView = UIView();
        //bgView.layer.cornerRadius = 10.0;
        bgView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha:0.7);
        cell.backgroundView = bgView;
        
        return cell
    }
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        let sec = indexPath.section 
        let row = indexPath.row

        AdMode = row
		tableView.reloadSections(NSIndexSet(index: sec),withRowAnimation: UITableViewRowAnimation.Left)
    }
    func OnOffAct(onoff: UISwitch)
    {
        println("\(DbgName) OnOffAct tag=\(onoff.tag)")
        var value = 0;
        if (onoff.on){
            value = 1
        }
        AdModeShrink = value
        /*
        switch onoff.tag {
        case 0:
            AdModeShrink = value
        default:
            AdModeGoNext = value
        }*/
    }
}
