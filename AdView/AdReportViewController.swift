//
import UIKit
//https://developer.apple.com/library/ios/documentation/userexperience/Conceptual/TableView_iPhone/TableViewStyles/TableViewCharacteristics.html
//Def: image+titel, sub: image+(title/subtitle), value1: left align title1+ title2, value2: title1+ left align title2 
//http://blog.csdn.net/kmyhy/article/details/6442351
//Disclosure: >, DetaiL: @>, Check: ^
//http://blog.csdn.net/lovefqing/article/details/8251587
class AdReportCell : UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//----------------------------------------------------------------------------	
class AdReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    let DbgName = "AdReportView"
	var AdId = "adsfsaf"
	var AdUrl = "http://yahoo.ca"
	var ChkAry = [0,0]

	var TableView: UITableView?
   	let CellIden = "Cell"	
    
	let space1 = UIView()	
	let ReportButton = UIButton()
	let CancelButton = UIButton()	
//----------------------------------------------------------------------------		
    override func viewDidLoad() {
        super.viewDidLoad()

		TableSet()
		InfoSet()
		
		LayoutSet()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//----------------------------------------------------------------------------		
	func TableSet(){
	    
		self.TableView = UITableView(frame:self.view.frame,style:UITableViewStyle.Grouped)  
        self.TableView!.dataSource = self  
        self.TableView!.delegate = self  
        self.TableView!.registerClass(AdReportCell.classForCoder(), forCellReuseIdentifier: CellIden)  
        self.view.addSubview(self.TableView!)  
	}
	func InfoSet(){
	
	    space1.hidden = true;
		//space1.frame = CGRectMake(0, 0, 40, 20)
		self.view.addSubview(space1)

	    ReportButton.frame = CGRectMake(100, 100, 100, 50)
        ReportButton.backgroundColor = UIColor.whiteColor()
		ReportButton.layer.cornerRadius = 8;
		ReportButton.layer.borderWidth = 1;
		ReportButton.layer.borderColor = UIColor.blueColor().CGColor;
		ReportButton.clipsToBounds = true;		
		//ReportButton.layer.masksToBounds = true;
        ReportButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal )
        ReportButton.setTitle(" Report ", forState: UIControlState.Normal)
		ReportButton.sizeToFit()	
        ReportButton.addTarget(self, action: "ReportButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(ReportButton)
		
	    CancelButton.frame = CGRectMake(100, 100, 100, 50)
        CancelButton.backgroundColor = UIColor.whiteColor()
		CancelButton.layer.cornerRadius = 8;
		CancelButton.layer.borderWidth = 1;
		CancelButton.layer.borderColor = UIColor.blueColor().CGColor;
		CancelButton.clipsToBounds = true;		
		//CancelButton.layer.masksToBounds = true;
        CancelButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal )
        CancelButton.setTitle(" Cancel ", forState: UIControlState.Normal)
		CancelButton.sizeToFit()	
        CancelButton.addTarget(self, action: "CancelButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(CancelButton)
	}
	func LayoutSet(){	
	
		var layout_dict = Dictionary <String, UIView>()
		layout_dict["TableView"] = TableView! 
		TableView!.setTranslatesAutoresizingMaskIntoConstraints(false)
		layout_dict["space1"] = space1 
		space1.setTranslatesAutoresizingMaskIntoConstraints(false)
		layout_dict["ReportButton"] = ReportButton 
		ReportButton.setTranslatesAutoresizingMaskIntoConstraints(false)
		layout_dict["CancelButton"] = CancelButton 
		CancelButton.setTranslatesAutoresizingMaskIntoConstraints(false)

        //NSLayoutConstraint.deactivateConstraints(self.view.constraints())
		
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
			"V:|-20-[TableView]-20-[space1(20)]-30-|",
			options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
			"H:|-20-[TableView]-20-|", 
			options: nil, metrics: nil, views: layout_dict))
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
			"H:|-(>=1)-[ReportButton][space1(60)][CancelButton]-(>=1)-|", 
			options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: layout_dict))			
	}
//----------------------------------------------------------------------------	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int{
	    
		return 2
	}
	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
	
		switch section{
		case 0:
		    return "Ad information"
		default:
			return "Website issue"
		}
	}
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
	
		println("\(DbgName) numberOfRowsInSection")
		switch section {
		case 0: return 2
		default: return 3
		}
    }  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{  
        
		let sec = indexPath.section 
		let row = indexPath.row
		println("\(DbgName) cellForRowAtIndexPath sec=\(sec),row=\(row)")
		
		let cell = tableView.dequeueReusableCellWithIdentifier(CellIden, forIndexPath:indexPath) as! AdReportCell		
		switch sec {
		case 0:
		    switch row {
			case 0: cell.textLabel!.text = "Id: \(AdId)"
			default: cell.textLabel!.text = "\(AdUrl)"
			}
		default:
		    switch row {
			case 0: cell.textLabel!.text = "Network failed."
			case 1: cell.textLabel!.text = "Content broken."
			default: cell.textLabel!.text = "Not the right info."
			}
		}

		if (sec > 0) {
			if (ChkAry[sec-1]==row+1){
				cell.accessoryType = UITableViewCellAccessoryType.Checkmark
			}
			else{
				cell.accessoryType = UITableViewCellAccessoryType.None
			}
		}
		return cell
    }  
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){ 
		
		let sec = indexPath.section 
		if (sec==0){
			return
		}
		let row = indexPath.row		
		ChkAry[sec-1]=row+1
		tableView.reloadSections(NSIndexSet(index: sec),withRowAnimation: UITableViewRowAnimation.Left)
    }  
//----------------------------------------------------------------------------
	func ReportButtonAction(sender:UIButton!)
    {
		println("\(DbgName) ReportButtonAction")
        self.dismissViewControllerAnimated(true, completion: nil);
    }
	
	func CancelButtonAction(sender:UIButton!)
    {
		println("\(DbgName) CancelButtonAction")
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}
/*
[tv beginUpdates];
    [tv insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
    [tv deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [tv endUpdates];
*/