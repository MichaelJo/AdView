//
//  AdItemHelpViewController.swift
//  AdView
//
//  Created by DavidWu on 2014-08-09.
//  Copyright (c) 2014 AditMax. All rights reserved.
//

import UIKit

class AdItemHelpCell : UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AdItemHelpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var DbgName = "AdItemHelpView"
    
    var InfoLbl = UILabel()
    var Info1Lbl = UILabel()
    var TableView: UITableView?
   	let CellIden = "Cell"	
    var dateString: String = ""
	let OkayButton = UIButton()
//----------------------------------------------------------------------------	    
    override func viewDidLoad() {
        println("\(DbgName) viewDidLoad")
        super.viewDidLoad()
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "America/Vancouver")
        dateString = formatter.stringFromDate(date)
        
        view.backgroundColor = UIColor.whiteColor()        
        HeadSet()
        TableSet()
		FootSet()
		LayoutSet()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func HeadSet(){
        InfoLbl.font = UIFont.systemFontOfSize(13.0)
        InfoLbl.textColor = UIColor(red: 0.02, green: 0.55, blue: 0.96, alpha: 1.0) //0.02, 0.55, 0.96
        InfoLbl.text = "Ad View shows the specific website of an Ad."
        InfoLbl.numberOfLines = 0;
        InfoLbl.lineBreakMode = .ByWordWrapping
        InfoLbl.textAlignment = .Left //NSTextAlignment.
        InfoLbl.sizeToFit()
        //CGRect currentFrame = myLabel.frame;
        //CGSize max = CGSizeMake(myLabel.frame.size.width, 500);
        //CGSize expected = [myString sizeWithFont:myLabel.font constrainedToSize:max lineBreakMode:myLabel.lineBreakMode];
        //currentFrame.size.height = expected.height;
        //myLabel.frame = currentFrame;
        InfoLbl.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(InfoLbl)
        
        Info1Lbl.font = UIFont.systemFontOfSize(11.0)
        Info1Lbl.text = "User should stay on this view for 20 seconds to get the points, before going to other View or watching last/next Ad."
        Info1Lbl.numberOfLines = 0;
        Info1Lbl.lineBreakMode = .ByWordWrapping
        Info1Lbl.textAlignment = .Left //NSTextAlignment.
        Info1Lbl.sizeToFit()
        //CGRect currentFrame = myLabel.frame;
        //CGSize max = CGSizeMake(myLabel.frame.size.width, 500);
        //CGSize expected = [myString sizeWithFont:myLabel.font constrainedToSize:max lineBreakMode:myLabel.lineBreakMode];
        //currentFrame.size.height = expected.height;
        //myLabel.frame = currentFrame;
        Info1Lbl.backgroundColor = UIColor.whiteColor()
        Info1Lbl.textColor = UIColor.blackColor()
        self.view.addSubview(Info1Lbl)

    }
    
    func TableSet(){
	    
		self.TableView = UITableView(frame:self.view.frame,style:UITableViewStyle.Plain)//.Grouped)
        self.TableView!.sectionFooterHeight = 0.0
        self.TableView!.sectionHeaderHeight = 0.0
        self.TableView!.dataSource = self  
        self.TableView!.delegate = self
        //Use th following for style =s.Grouped
        //self.TableView!.contentInset = UIEdgeInsetsMake(-20, 0, -20, 0);
        self.TableView!.registerClass(AdItemHelpCell.classForCoder(), forCellReuseIdentifier: CellIden)  
        self.view.addSubview(self.TableView!)  
	}
	func FootSet(){
	
  	    OkayButton.frame = CGRectMake(100, 100, 100, 50)
        OkayButton.backgroundColor = UIColor.whiteColor()
		OkayButton.layer.cornerRadius = 8;
		OkayButton.layer.borderWidth = 1;
		OkayButton.layer.borderColor = UIColor.grayColor().CGColor;
		OkayButton.clipsToBounds = true;		
		//OkayButton.layer.masksToBounds = true;
        OkayButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal )
        OkayButton.setTitle(" Return ", forState: UIControlState.Normal)
		OkayButton.sizeToFit()	
        OkayButton.addTarget(self, action: "OkayButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(OkayButton)
	}
	func LayoutSet(){	
	
		var layout_dict = Dictionary <String, UIView>()
        self.view.addConstraint(NSLayoutConstraint(
            item: InfoLbl, attribute:.CenterX, relatedBy:.Equal,
            toItem:self.view, attribute:.CenterX, multiplier:1, constant:0))
        
        layout_dict["InfoLbl"] = InfoLbl
        InfoLbl.setTranslatesAutoresizingMaskIntoConstraints(false)
        layout_dict["Info1Lbl"] = Info1Lbl
        Info1Lbl.setTranslatesAutoresizingMaskIntoConstraints(false)
		layout_dict["TableView"] = TableView!
		TableView!.setTranslatesAutoresizingMaskIntoConstraints(false)
		layout_dict["OkayButton"] = OkayButton 
		OkayButton.setTranslatesAutoresizingMaskIntoConstraints(false)

        //NSLayoutConstraint.deactivateConstraints(self.view.constraints())
		
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
			"V:|-30-[InfoLbl]-10-[Info1Lbl]-10-[TableView]-20-[OkayButton]-30-|",
			options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-(>=20)-[InfoLbl]-(>=20)-|",
            options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[Info1Lbl]-20-|",
            options: nil, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
			"H:|-20-[TableView]-20-|", 
			options: nil, metrics: nil, views: layout_dict))
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
			"H:|-(>=1)-[OkayButton]-(>=1)-|", 
			options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: layout_dict))			
	}    
//----------------------------------------------------------------------------	        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("\(DbgName) cellForRowAtIndexPath row=\(indexPath.row)")
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIden, forIndexPath:indexPath) as! AdItemHelpCell

        switch(indexPath.row){
        case 0:
            cell.textLabel!.text = "Rate it"
            cell.imageView!.image = UIImage(named: "RateImage")
            cell.detailTextLabel!.text = "How helpful is the Ad?"
        case 1:
            cell.textLabel!.text = "Share it"
            cell.imageView!.image = UIImage(named: "ShareImage")
            cell.detailTextLabel!.text = "If you like the Ad, why not share it?"
        case 2:
            cell.textLabel!.text = "Report it"
            cell.imageView!.image = UIImage(named: "ReportImage")
            cell.detailTextLabel!.text = "Missing/undesired content? Report it"
        case 3:
            cell.textLabel!.text = "Previous Ad"
            cell.imageView!.image = UIImage(named: "GoLastImage")
            cell.detailTextLabel!.text = "Show previous ad"
        case 4:
            cell.textLabel!.text = "Next Ad"
            cell.imageView!.image = UIImage(named: "GoNextImage")
            cell.detailTextLabel!.text = "Show next Ad"
        default: //idx=5,num=6
            cell.textLabel!.text = "Info"
            cell.imageView!.image = UIImage(named: "InfoImage")
            cell.detailTextLabel!.text = "Ad View info"
        }
        
        return cell;
    }
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
//----------------------------------------------------------------------------        
    func OkayButtonAction(sender:UIButton!)
    {
		println("\(DbgName) OkayButtonAction")
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}
