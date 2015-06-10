//

import UIKit
//https://developer.apple.com/library/ios/documentation/userexperience/Conceptual/TableView_iPhone/TableViewStyles/TableViewCharacteristics.html
//Def: image+titel, sub: image+(title/subtitle), value1: left align title1+ title2, value2: title1+ left align title2 
//http://blog.csdn.net/kmyhy/article/details/6442351
//Disclosure: >, DetaiL: @>, Check: ^
//http://blog.csdn.net/lovefqing/article/details/8251587
//----------------------------------------------------------------------------	
protocol AdRateDelegate{
    func rateButtonClicked(controller:AdRateViewController, error: String, count:Int)
}
class AdRateViewController: UIViewController,ServerManagerDelegate {
    var delegate:AdRateDelegate! = nil
    let DbgName = "AdRateView"
    
    var AdId :String = ""
    var AdRate :Int = 0
    var StartDateString :String = ""
    var StarAry : Array<UIButton> = []
	let Star0Button = UIButton()
	let Star1Button = UIButton()	
	let Star2Button = UIButton()
	let Star3Button = UIButton()	
	let Star4Button = UIButton()	
    let Star5Button = UIButton()
    let Star6Button = UIButton()
    
	let space1 = UIView()	
	let RateButton = UIButton()
	let CancelButton = UIButton()	
//----------------------------------------------------------------------------		
    func ratingSubmitted(error: String, adsViewed: Int){
        delegate.rateButtonClicked(self, error: error,count: adsViewed)
    }
    func adsListLoaded(error: String, adsViewed: Int) {
     }
    func loginFailed(error: String) {
        
    }
    override func viewDidLoad() {
        println("\(DbgName) viewDidLoad")    
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
		StarSet()
		InfoSet()
		
		LayoutSet()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//----------------------------------------------------------------------------		
	func StarSet(){

        let OffImage = UIImage(named: "StarOffImage")
        
        for idx in 0...6 {
            StarAry.append(UIButton())
            StarAry[idx].frame = CGRectMake(100, 100, 100, 100)
            StarAry[idx].setImage(OffImage, forState: UIControlState.Disabled)
            StarAry[idx].enabled = false
            self.view.addSubview(StarAry[idx])
        }
		StarAry[0].hidden = true
        StarAry[6].hidden = true
 	}
	func InfoSet(){
	
	    space1.hidden = true;
		//space1.frame = CGRectMake(0, 0, 40, 20)
		self.view.addSubview(space1)

	    RateButton.frame = CGRectMake(100, 100, 100, 50)
        RateButton.backgroundColor = UIColor.whiteColor()
		RateButton.layer.cornerRadius = 8;
		RateButton.layer.borderWidth = 1;
		RateButton.layer.borderColor = UIColor.blueColor().CGColor;
		RateButton.clipsToBounds = true;		
		//RateButton.layer.masksToBounds = true;
        RateButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal )
        RateButton.setTitle(" Rate ", forState: UIControlState.Normal)
		RateButton.sizeToFit()	
        RateButton.addTarget(self, action: "RateButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(RateButton)
		
	    CancelButton.frame = CGRectMake(100, 100, 100, 50)
        CancelButton.backgroundColor = UIColor.whiteColor()
		CancelButton.layer.cornerRadius = 8;
		CancelButton.layer.borderWidth = 1;
		CancelButton.layer.borderColor = UIColor.grayColor().CGColor;
		CancelButton.clipsToBounds = true;		
		//CancelButton.layer.masksToBounds = true;
        CancelButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal )
        CancelButton.setTitle(" Cancel ", forState: UIControlState.Normal)
		CancelButton.sizeToFit()	
        CancelButton.addTarget(self, action: "CancelButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(CancelButton)
	}
	func LayoutSet(){	
	    //CenterX option ont work by V:|-80-[Star2Button]-(>=1)-|" + centerx 
        self.view.addConstraint(NSLayoutConstraint(
            item: StarAry[3], attribute:.CenterX, relatedBy:.Equal,
            toItem:self.view, attribute:.CenterX, multiplier:1, constant:0))
		var layout_dict = Dictionary <String, UIView>()
        
        for idx in 0...6 {
            layout_dict["Star\(idx)Button"] = StarAry[idx]
            StarAry[idx].setTranslatesAutoresizingMaskIntoConstraints(false)
        }
        layout_dict["space1"] = space1
		space1.setTranslatesAutoresizingMaskIntoConstraints(false)
		layout_dict["RateButton"] = RateButton 
		RateButton.setTranslatesAutoresizingMaskIntoConstraints(false)
		layout_dict["CancelButton"] = CancelButton 
		CancelButton.setTranslatesAutoresizingMaskIntoConstraints(false)

        //NSLayoutConstraint.deactivateConstraints(self.view.constraints())		
		
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-80-[Star3Button]-60-[space1(20)]-(>=1)-|",
			options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: layout_dict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
			"H:|-(>=1)-[Star0Button][Star1Button][Star2Button][Star3Button][Star4Button][Star5Button][Star6Button]-(>=1)-|",
			options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: layout_dict))
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
			"H:|-(>=1)-[RateButton][space1(60)][CancelButton]-(>=1)-|", 
			options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: layout_dict))			
	}
//----------------------------------------------------------------------------
	func ChgStars(cnt: Int){
        if (AdRate == cnt){
            return
        }
        
        let OffImage = UIImage(named: "StarOffImage") 
        let OnImage = UIImage(named: "StarOnImage")
        println("\(DbgName) ChgStars \(AdRate)->\(cnt)")
        var idx = 0
        if (AdRate<cnt){
            for idx = AdRate;idx <= cnt; idx+=1{
                StarAry[idx].setImage(OnImage, forState: UIControlState.Disabled)
            }
        }
        else{
            for idx = AdRate;idx > cnt; idx-=1{
                StarAry[idx].setImage(OffImage, forState: UIControlState.Disabled)
            }
        }
        AdRate = cnt
    }
    
    func ChkIdx(location: CGPoint) -> Int {
        
        var idx = 0
        for idx=0; idx<7; idx+=1 {
            if CGRectContainsPoint(StarAry[idx].frame, location) {
                return idx
            }
        }
            
        return -1
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    
        for obj: AnyObject in touches {
            let touch = obj as! UITouch
            let location = touch.locationInView(self.view)
            let res = ChkIdx(location)
            println("\(DbgName) touchesBegan idx=\(res)")
        }
    }

    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for obj: AnyObject in touches {
            let touch = obj as! UITouch
            let location = touch.locationInView(self.view)
            let res = ChkIdx(location)
            //println("\(DbgName) touchesMoved idx=\(res)")
            if (res<0){
                break;
            }
            ChgStars(res)
        }
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
           for obj: AnyObject in touches {
            let touch = obj as! UITouch
            let location = touch.locationInView(self.view)
            let res = ChkIdx(location)
            println("\(DbgName) touchesEnded idx=\(res)")
            if (res<0){
                break;
            }
            ChgStars(res)
        }
    }
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
         
        for obj: AnyObject in touches {
            let touch = obj as! UITouch
            let location = touch.locationInView(self.view)
            let res = ChkIdx(location)
            println("\(DbgName) touchesCancelled idx=\(res)")
            if (res<0){
                break;
            }
            //ChgStars(res)
        }
    }
    
	func Star0ButtonAction(sender:UIButton!){
		println("\(DbgName) Star0ButtonAction")
        ChgStars(1)
        //self.dismissViewControllerAnimated(true, completion: nil);
    }
	func Star1ButtonAction(sender:UIButton!){
		println("\(DbgName) Star1ButtonAction")
        ChgStars(2)
        //self.dismissViewControllerAnimated(true, completion: nil);
    }
	func Star2ButtonAction(sender:UIButton!){
		println("\(DbgName) Star2ButtonAction")
        ChgStars(3)
        //self.dismissViewControllerAnimated(true, completion: nil);
    }
	func Star3ButtonAction(sender:UIButton!){
		println("\(DbgName) Star3ButtonAction")
        ChgStars(4)
        //self.dismissViewControllerAnimated(true, completion: nil);
    }
	func Star4ButtonAction(sender:UIButton!){
		println("\(DbgName) Star4ButtonAction")    
        ChgStars(5)
        //self.dismissViewControllerAnimated(true, completion: nil);
    }
	func RateButtonAction(sender:UIButton!){
		println("\(DbgName) RateButtonAction")
        var serverManager = ServerManager()
        serverManager.delegate = self
        serverManager.rate(AdId,adRate: AdRate,startDateString: StartDateString)
        self.dismissViewControllerAnimated(true, completion: nil);

    }
	func CancelButtonAction(sender:UIButton!){
		println("\(DbgName) CancelButtonAction")
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}
