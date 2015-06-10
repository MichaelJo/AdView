//
//  TMHomePageViewController.m
//
//  Created by Alex Song.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import "TMHomePageViewController.h"
#import "TMClassicViewController.h"
#import "FCsetViewController.h"
#import "TMShopStoreDetailScrollController.h"
#import "TMThirdClassViewController.h"
#import "TMGoodsDetailsViewController.h"
#import "Adviewer-Swift.h"
#import "SDSyncEngine.h"
#import "DejalActivityView.h"

@interface TMHomePageViewController ()
{
    UrlImageButton *btn;
    UILabel *label1;
    UrlImageButton *fourBtn;
    UILabel *fourLab;
    UIView *_view;
    NSArray *products;
}
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation TMHomePageViewController
@synthesize dateFormatter;
@synthesize managedObjectContext;

@synthesize entityName;
@synthesize dates;

- (void)loadRecordsFromCoreData {
    CoreDataBase *cdb = [[CoreDataBase alloc] init];
    products = [cdb getList];
    [cdb getNormalList];
    [cdb getSuperList];
    [cdb getPromoList];
    
    if (products.count == 0) {
        return;
    }
    [self.managedObjectContext performBlockAndWait:^{
        [self.managedObjectContext reset];
        NSError *error = nil;
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName: @"Product"];
        [request setSortDescriptors:[NSArray arrayWithObject:
                                     [NSSortDescriptor sortDescriptorWithKey:@"start_date" ascending:YES]]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"syncStatus != %d", SDObjectDeleted]];
        self.dates = [self.managedObjectContext executeFetchRequest:request error:&error];
    }];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SDSyncEngineSyncCompleted" object:nil];

}
-(UIView*)initNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
    UIView *view_bar =[[UIView alloc]init];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>6.1)
    {
        view_bar.frame=CGRectMake(0, 0, self.view.frame.size.width, 44+20);
        
    }else{
        view_bar.frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
    }
    
    //top bar background image
    UIImageView *imageV = [[UIImageView alloc]initWithImage:BundleImage(@"top.png")];
    [view_bar addSubview:imageV];
    [imageV release];
    
    view_bar.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview: view_bar];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
//    title_label.text=@"首页";
    title_label.text=NSLocalizedString(@"HELLO", comment:"");
  //  let s1 = NSLocalizedString("HELLO", comment:"")

    title_label.font=[UIFont boldSystemFontOfSize:20];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
 
    UIButton*btnBack=[UIButton buttonWithType:0];
    btnBack.frame=CGRectMake(self.view.frame.size.width-40, view_bar.frame.size.height-38, 38, 38);
    [btnBack setImage:BundleImage(@"sy_setup.png") forState:0];
    [btnBack addTarget:self action:@selector(btnSet:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnBack];
    
    return view_bar;
}
-(void)btnSet:(id)sender
{
    FCsetViewController *set=[[FCsetViewController alloc]init];
      TMAppDelegate *appDelegate = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:set animated:YES];

}

- (EScrollerView *)drawTopScrollerView
{
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, 320, 160)
                                                          scrolArray:[NSArray arrayWithArray:self._scrol_marray] needTitile:YES];
    scroller.delegate=self;
    scroller.backgroundColor=[UIColor clearColor];
    return scroller;
}

-(void)drawViewRect
{
    UIView*naviView=(UIView*) [self initNavigationBar];
    CoreDataBase *cdb = [[CoreDataBase alloc] init];

    //        for (int i=0; i<[[[data objectForKey:@"news"]objectForKey:@"content"] count]; i++)
    //        {
    //            NSDictionary *dic = [[[data objectForKey:@"news"]objectForKey:@"content"] objectAtIndex:i];
    //            [_newsArray addObject:dic];
    //        }
    //
    //
    //        self._scrol_marray = [NSMutableArray arrayWithArray:[data objectForKey:@"focus"]];
    NSArray * superlist = [cdb getPromoList];

    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    for (int i =0; i<3 && i < superlist.count; i++)
    {
        [newArray addObject:[superlist objectAtIndex:i]];
        //[self._scrol_marray
    }
    self._scrol_marray = [NSMutableArray arrayWithArray: newArray];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, naviView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-naviView.frame.size.height-49)];
    
    if (IS_IPHONE_5) {
        
        [_scrollView setContentSize:CGSizeMake(320, self.view.frame.size.height+15)];
    }else{
        [_scrollView setContentSize:CGSizeMake(320, self.view.frame.size.height+120)];
    }
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self.view addSubview:_scrollView];
    
    EScrollerView *scroller = [self drawTopScrollerView];
    [_scrollView addSubview:scroller];

    
    //cell.image = [UIImage imageWithData: imageData];
    //draw new products
    products = [cdb getSuperList];

/*    if (products.count < 6){
        return;
    }*/
    int rows = products.count / 3 + 1;
    int index = 0;
    for (int currentRow=0; currentRow < rows; currentRow++)
    {
        for (int currentCol =0; currentCol < 3 && currentRow * 3 + currentCol < products.count; currentCol++) {
            
            index = currentRow * 3 + currentCol;
        btn=[[UrlImageButton alloc]initWithFrame:CGRectMake(12+currentCol*100, scroller.frame.size.height+scroller.frame.origin.y+10+currentRow*100, 95, 70)];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[products objectAtIndex:index] image]]];

        [btn setImage:[UIImage imageWithData:imageData] forState:0];
        
        [_scrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnGoodsList:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor clearColor];
        btn.accessibilityHint = [[products objectAtIndex:index] pid];
        //[btn setValue:[[products objectAtIndex:i] pid] forKey:@"@currentTitle"];
        [btn setTitle:[[products objectAtIndex:index] pid] forState:UIControlStateNormal];
        
        label1=[[UILabel alloc]initWithFrame:CGRectMake(12+currentCol*100, btn.frame.size.height+btn.frame.origin.y+5, 95, 20)];
        //TMAppDelegate
        label1.text= [[products objectAtIndex:index] name]; //[[cdb getOne] name];//@"新品装|New";
        //ServerManagernam
        label1.textColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
        label1.font=[UIFont systemFontOfSize:11];
        label1.textAlignment=1;
        label1.backgroundColor=[UIColor clearColor];
 
        [_scrollView addSubview:label1];
        }
       
    }
 
    /*
    if (products.count < 8){
        return;
    }
    for (int i=0; i < 2; i++)
    {
        btn=[[UrlImageButton alloc]initWithFrame:CGRectMake(12+i*100, scroller.frame.size.height+scroller.frame.origin.y+110, 95, 70)];
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[products objectAtIndex:i+6] image]]];
        
        [btn setImage:[UIImage imageWithData:imageData] forState:0];
        
        [_scrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnGoodsList:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor clearColor];
        //[btn setValue:[[products objectAtIndex:i] pid] forKey:@"@currentTitle"];
        [btn setTitle:[[products objectAtIndex:i] pid] forState:UIControlStateNormal];
        
        label1=[[UILabel alloc]initWithFrame:CGRectMake(12+i*100, btn.frame.size.height+btn.frame.origin.y+5, 95, 20)];
        //TMAppDelegate
        label1.text= [[products objectAtIndex:i] name]; //[[cdb getOne] name];//@"新品装|New";
        //ServerManagernam
        label1.textColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
        label1.font=[UIFont systemFontOfSize:11];
        label1.textAlignment=1;
        label1.backgroundColor=[UIColor clearColor];
        
        [_scrollView addSubview:label1];
        
    }*/
    /*
    //draw subtitle bar
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0,label1.frame.size.height+label1.frame.origin.y+6 , self.view.frame.size.width, 33)];
    img.image=BundleImage(@"titlebar.png");
    img.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:img];
    [img release];
    
  
    //draw store list
    for (int i =0; i<4; i++)
    {
        fourBtn=[[UrlImageButton alloc]initWithFrame:CGRectMake(12+i*75, img.frame.size.height+img.frame.origin.y+8, 70, 70)];
        [fourBtn addTarget:self action:@selector(btnShopStore:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:fourBtn];
        [fourBtn setBackgroundImage: [UIImage imageNamed:@"default_02.png"] forState:0];
         [fourBtn setImage: [UIImage imageNamed:@"spic_01.png"] forState:0];
        fourLab=[[UILabel alloc]initWithFrame:CGRectMake(12+i*75, fourBtn.frame.size.height+fourBtn.frame.origin.y+8, 70, 20)];
        fourLab.text=@"爱迪酷我";
        fourLab.textColor=[UIColor grayColor];
        fourLab.font=[UIFont boldSystemFontOfSize:10];
        fourLab.textAlignment=1;
        fourLab.backgroundColor=[UIColor clearColor];
        [_scrollView addSubview:fourLab];
        
    }
    */
    //draw categories
    _view=[[UIView alloc]initWithFrame:CGRectMake(0, fourLab.frame.size.height+fourLab.frame.origin.y+10, 320, 170)];
    
    //Commented out the categories
    /*
    int imageCount=9;
    
    if (imageCount>8)
    {
        for (int i =0; i<7; i++)
        {
            
            _view.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            [_scrollView addSubview:_view];
            
            UrlImageButton *btnNine=[[UrlImageButton alloc]initWithFrame:CGRectMake((i%4)*75+12, floor(i/4)*75+10, 70, 70)];
            [btnNine setImage:[UIImage imageNamed:@"pic_02.png"] forState:0];
            btnNine.backgroundColor=[UIColor clearColor];
            [btnNine addTarget:self action:@selector(btnFenlei:) forControlEvents:UIControlEventTouchUpInside];
            [_view addSubview:btnNine];
            
            
            UrlImageButton *btn8=[[UrlImageButton alloc]initWithFrame:CGRectMake((7%4)*75+12, floor(7/4)*75+10, 70, 70)];
            [btn8 setImage:[UIImage imageNamed:@"pic_03.png"] forState:0];
            [_view addSubview:btn8];

            
            UrlImageView*image=[[UrlImageView alloc]initWithFrame:CGRectMake(2, 1, 70-5, 50)];
            [btnNine addSubview:image];
            [image setImage:[UIImage imageNamed:@"default_04.png"]];
            image.layer.borderWidth=1;
            image.layer.cornerRadius = 4;
            image.layer.borderColor = [[UIColor clearColor] CGColor];
            image.backgroundColor=[UIColor clearColor];
            
            UILabel *labelLine=[[UILabel alloc]initWithFrame:CGRectMake(2, 50+10, 70-4, 1)];
            labelLine.backgroundColor=[UIColor grayColor];
            [btnNine addSubview:labelLine];
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 20, 15)];
            label.font = [UIFont boldSystemFontOfSize:10.0f];  //UILabel的字体大小
            label.numberOfLines = 0;  //必须定义这个属性，否则UILabel不会换行
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;  //文本对齐方式
            [label setBackgroundColor:[UIColor whiteColor]];
            
            //高度固定不折行，根据字的多少计算label的宽度
            NSString *str = @"温哥华星";
            CGSize size = [str sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, label.frame.size.height)];
            //        NSLog(@"size.width=%f, size.height=%f", size.width, size.height);
            //根据计算结果重新设置UILabel的尺寸
            [label setFrame:CGRectMake((70-size.width)/2, 52, size.width+4, 15)];
            label.text = str;  
            
            [btnNine addSubview:label];

        }

    }*/
    
}

-(void)btnGoodsList:(id)sender
{

/*    TMThirdClassViewController *third=[[TMThirdClassViewController alloc]init];
    UIButton *btn = (UIButton*)sender;
    third.pid = [btn titleForState:UIControlStateNormal];
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController pushViewController:third animated:YES];
  */
    TMGoodsDetailsViewController *goodsDetail=[[TMGoodsDetailsViewController alloc]init];
    UIButton *btn = (UIButton*)sender;
    //third.pid = [btn titleForState:UIControlStateNormal];
    goodsDetail.pid = [btn titleForState:UIControlStateNormal];
    //MainViewController *mvc = [[MainViewController alloc]init];
    AppDelegate *app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController pushViewController:goodsDetail animated:YES];

}
-(void)btnShopStore:(id)sender
{
    TMShopStoreDetailScrollController *shopStore=[[TMShopStoreDetailScrollController alloc]init];
    TMAppDelegate *appDelegate = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:shopStore animated:YES];
}
-(void)btnFenlei:(id)sender
{
    TMClassicViewController*classIC=[[TMClassicViewController alloc]initWithWhere:@"first"];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:classIC animated:YES];

}
-(void)viewDidLoad
{

//    NSString *parmeters1=[NSString stringWithFormat:@"%@&%@&%@",@"page=1",@"pageSize=5",[NSString stringWithFormat:@"menuId=%d",_typeId]];
//    
//    [[RequestServer instance] doActionAsync:0 withAction:@"/mobile/second?" withParameters:parmeters1 withDelegate:self];
    //[super viewDidLoad];
    self.entityName = @"Product";
    self.managedObjectContext = [[SDCoreDataController sharedInstance] newManagedObjectContext];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    //            [[SDSyncEngine sharedEngine] saveContext];
    
    //[self drawViewRect];
    //[self checkSyncStatus];
    //AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    //[appDel startLoading];
    //[DejalBezelActivityView activityViewForView: self];
    [self loadData];
    if(&UIApplicationWillEnterForegroundNotification) { //needed to run on older devices, otherwise you'll get EXC_BAD_ACCESS
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self selector:@selector(enteredForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    //[[SDSyncEngine sharedEngine] addObserver:self forKeyPath:@"syncInProgress" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)loadData{
    [self loadRecordsFromCoreData];
    if (products.count > 0) {
        [self drawViewRect];
    }else{
        [DejalActivityView activityViewForView:self.view];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:@"SDSyncEngineSyncCompleted" object:nil queue:nil usingBlock:^(NSNotification *note) {
            [self loadRecordsFromCoreData];
            [self drawViewRect];
        }];
    }
    
}
- (void)enteredForeground:(NSNotification*) not
{
    [self loadData];
    //do stuff here
}
- (void)viewDidDisappear:(BOOL)animated {
    //[[SDSyncEngine sharedEngine] removeObserver:self forKeyPath:@"syncInProgress"];
}

- (void)checkSyncStatus {
    if ([[SDSyncEngine sharedEngine] syncInProgress]) {
        [self replaceRefreshButtonWithActivityIndicator];
    } else {
        [self removeActivityIndicatorFromRefreshButon];
    }
}

- (void)replaceRefreshButtonWithActivityIndicator {
            AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    [appDel startLoading];
    //title_label.text=NSLocalizedString(@"replace refresh button...", comment:"");
/*
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [activityIndicator setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)];
    [activityIndicator startAnimating];
    UIBarButtonItem *activityItem = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    self.navigationItem.leftBarButtonItem = activityItem;
*/}

- (void)removeActivityIndicatorFromRefreshButon {
    //AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    //[appDel stopLoading];
    //title_label.text=NSLocalizedString(@"removed activity indic...", comment:"");
    //self.navigationItem.leftBarButtonItem = self.refreshButton;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"syncInProgress"]) {
        [self checkSyncStatus];
    }
}
//
//-(void)requestFinished:(NSNumber *)code withMessage:(NSString *)message withData:(id)data
//{
//    
//    
//    if(_page ==1&&_newsArray.count>0)
//    {
//        [_newsArray removeAllObjects];
//        
//        for (int i=0; i<[[[data objectForKey:@"news"]objectForKey:@"content"] count]; i++)
//        {
//            NSDictionary *dic = [[[data objectForKey:@"news"]objectForKey:@"content"] objectAtIndex:i];
//            [_newsArray addObject:dic];
//        }
//        
//        
//        self._scrol_marray = [NSMutableArray arrayWithArray:[data objectForKey:@"focus"]];
//        if(self._scrol_marray.count != 0)
//        {
//       
//        }
//            }
//    else
//    {
//        for (int i=0; i<[[[data objectForKey:@"news"]objectForKey:@"content"] count]; i++)
//        {
//            NSDictionary *dic = [[[data objectForKey:@"news"]objectForKey:@"content"] objectAtIndex:i];
//            [_newsArray addObject:dic];
//        }
//        
//        
//        self._scrol_marray = [NSMutableArray arrayWithArray:[data objectForKey:@"focus"]];
//        if(self._scrol_marray.count != 0)
//        {
//            
//        }
// 
//    }
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
