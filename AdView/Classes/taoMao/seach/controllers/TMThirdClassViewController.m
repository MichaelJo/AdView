//
//  TMThirdClassViewController.m
//  TaoMao
//
//  Created by Alex Song on 14-4-17.
//  Copyright (c) 2015 AditMax. All rights reserved.
//

#import "TMThirdClassViewController.h"
#import "TMGoodsDetailsViewController.h"
#import "AdViewer-Swift.h"
#import"AdPreferences.h"

@interface TMThirdClassViewController ()

@end

@implementation TMThirdClassViewController
-(id)initWithTopbar:(BOOL)showTopbar
{
    self=[super init];
    if (self)
    {
        _showTopbar=showTopbar;
    }
    return self;
}
-(UIView*)initNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
    UIView *view_bar =[[UIView alloc]init];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>6.1)
    {
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44+20);
        UIImageView *imageV = [[UIImageView alloc]initWithImage:BundleImage(@"top.png")];
        [view_bar addSubview:imageV];
        [imageV release];
        
    }else{
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
        UIImageView *imageV = [[UIImageView alloc]initWithImage:BundleImage(@"top.png")];
        [view_bar addSubview:imageV];
        [imageV release];
    }
    view_bar.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview: view_bar];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"商品列表";
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
    [title_label release];
    
    return view_bar;
}
-(void)btnBack:(id)sender
{
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0];
    navigationBar=(UIView*)[self initNavigationBar];
    UIView*toolBar=(UIView*)[self initToolBar];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, toolBar.frame.size.height+navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-toolBar.frame.size.height-49)];
    
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self.view addSubview:_scrollView];
    [self initGirdView:0];
    CoreDataBase *cdb = [[CoreDataBase alloc] init];
    [cdb preSetProductLists];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"popProductsUpdated" object:nil queue:nil usingBlock:^(NSNotification *note) {
        //[self addViews];
        [self initGirdView: 0];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"superProductsUpdated" object:nil queue:nil usingBlock:^(NSNotification *note) {
        //[self addViews];
        [self initGirdView:0];
    }];
    
}
-(void)initGirdView:(NSInteger) tabIndex
{
    AdPreferences *prefs = [AdPreferences sharedInstance];

    UrlImageView *imageV;   //底图为了描边
    NSString* currentId;
    CoreDataBase *cdb = [[CoreDataBase alloc] init];
    
    AdProduct *product;
    
    NSArray *array;
    if(_showTopbar)
    {
       array  = prefs.superProductIdArray;
    if (tabIndex == 0) {
        array = prefs.popProductIdArray;
    }else if(tabIndex == 1){
        array = prefs.cartItemDealIdArray;
    }
    }else{
        //array = _pIdArray;
        NSLog(_merchantId);
        array = [cdb getListByMerchant:_merchantId];
    }
    //product = [cdb getOne:self.pid];
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for (int i =0; i<[array count]; i++)
        {
            if(_showTopbar)
            {
            currentId = [array objectAtIndex:i];
            product = [cdb getOne:currentId];
            }else{
                product =[array objectAtIndex:i];
                currentId = [product pid];
            }
                imageV=[[UrlImageView alloc]initWithFrame:CGRectMake((i%2)*153+13, floor(i/2)*200+10, 140, 140)];
            imageV.backgroundColor=[UIColor redColor];
            imageV.userInteractionEnabled=YES;
//            btn.layer.shadowOffset = CGSizeMake(1,1); 
//            btn.layer.shadowOpacity = 0.2f;
//            btn.layer.shadowRadius = 3.0;
            imageV.layer.borderWidth=1;//描边
            imageV.layer.cornerRadius=4;//圆角
            imageV.layer.borderColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
            imageV.backgroundColor=[UIColor whiteColor];
           
            [_scrollView addSubview:imageV];
            
            UrlImageButton*btn=[[UrlImageButton alloc]initWithFrame:CGRectMake(2, 2, 140-4, 140-4)];
            btn.userInteractionEnabled=YES;
            btn.layer.borderWidth=1;//描边
            btn.layer.cornerRadius=4;//圆角
            btn.layer.borderColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
            btn.backgroundColor=[UIColor whiteColor];
            btn.accessibilityHint = currentId;
            //UrlImageView *headImg=[[UrlImageView alloc]initWithFrame:CGRectMake(90/2-60/2, 15, 60, 60)];
            
            //NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[merchants objectAtIndex:indexPath.row] imageUrl]]];
            
            //        [btn setImage:[UIImage imageWithData:imageData] forState:0];
            NSString * imageUrl = [product image];
            //[headImg setImageWithURL:[NSURL URLWithString: imageUrl]];
            [btn setImageWithURL:[NSURL URLWithString: imageUrl]];

            [btn setBackgroundImage:BundleImage(@"df_04_.png") forState:0];
            [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
//            [imageV addSubview:btn];
            [imageV insertSubview:btn aboveSubview:imageV];
            
            UILabel *_label=[[UILabel alloc]initWithFrame:CGRectMake((i%2)*153+13, floor(i/2)*200+10+140, 140, 40)];
            _label.text=[product name];
            _label.font=[UIFont boldSystemFontOfSize:14];
            _label.backgroundColor=[UIColor clearColor];
            _label.textColor =[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0];
            _label.numberOfLines=2;
            _label.textAlignment=0;
   
            [_scrollView addSubview:_label];

            
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 20, 15)];
//            label.font = [UIFont boldSystemFontOfSize:10.0f];  //UILabel的字体大小
//            label.numberOfLines = 0;  //必须定义这个属性，否则UILabel不会换行
//            label.textColor = [UIColor grayColor];
//            label.textAlignment = NSTextAlignmentCenter;  //文本对齐方式
//            [label setBackgroundColor:[UIColor whiteColor]];
//            
//            //高度固定不折行，根据字的多少计算label的宽度
//            NSString *str = @"高度";
//            CGSize size = [str sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, label.frame.size.height)];
//            //        NSLog(@"size.width=%f, size.height=%f", size.width, size.height);
//            //根据计算结果重新设置UILabel的尺寸
//            [label setFrame:CGRectMake((70-size.width)/2, 52, size.width+4, 15)];
//            label.text = str;

            
            UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake((i%2)*153+13, floor(i/2)*200+140+10+_label.frame.size.height, 65, 20)];
            title_label.text=[product adPoints];//@"￥199.00";
            title_label.font=[UIFont systemFontOfSize:12];
            title_label.backgroundColor=[UIColor clearColor];
            title_label.textColor =hongShe;
            title_label.textAlignment=0;

//
            [_scrollView addSubview:title_label];
            /*
            UILabel *title_label1=[[UILabel alloc]initWithFrame:CGRectMake((i%2)*153+13+title_label.frame.size.width, floor(i/2)*200+140+10+_label.frame.size.height, 65, 20)];
            title_label1.text=@"199.70";
            title_label1.font=[UIFont systemFontOfSize:10];
            title_label1.backgroundColor=[UIColor clearColor];
            title_label1.textColor =[UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1.0];
            title_label1.textAlignment=0;
            
            [_scrollView addSubview:title_label1];
            
                     //高度固定不折行，根据字的多少计算label的宽度
            NSString *str = title_label1.text;
           CGSize size = [str sizeWithFont:title_label.font constrainedToSize:CGSizeMake(MAXFLOAT, title_label.frame.size.height)];
//                     NSLog(@"size.width=%f, size.height=%f", size.width, size.height);
                     //根据计算结果重新设置UILabel的尺寸

            
            UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, title_label1.frame.size.height/2, size.width, 1)];
            line.image=BundleImage(@"line_01_.png");
            [title_label1 addSubview:line];
            [line release];
*/
        }
    [_scrollView setContentSize:CGSizeMake(320, (floor(11/2)+1)*200+30)];
}
#pragma mark红色线条动画

- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
    CGFloat tabItemWidth = self.view.frame.size.width/3;
    return (tabIndex * tabItemWidth+ tabItemWidth/3-4);
}


-(UIView*)initToolBar
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, navigationBar.frame.size.height, self.view.frame.size.width,35 )];
    imageView.backgroundColor=[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0];
    imageView.userInteractionEnabled=YES;
    [self.view addSubview:imageView];
    
    if (_showTopbar) {
    
    
    BtnItem1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [BtnItem1 setFrame:CGRectMake(0, 0, 320/3, 35)];
    BtnItem1.exclusiveTouch=YES;
    BtnItem1.tag = 100;
    [BtnItem1 setTitle:@"默认" forState:0];
    BtnItem1.titleLabel.textAlignment=1;
    BtnItem1.titleLabel.textColor=   hongShe;

    BtnItem1.layer.borderColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0].CGColor;
    BtnItem1.backgroundColor=[UIColor whiteColor];
    [BtnItem1 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:BtnItem1];
    

    BtnItem2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [BtnItem2 setFrame:CGRectMake(320/3*1+1, 0, 320/3, 35)];

    BtnItem2.exclusiveTouch=YES;
    BtnItem2.tag = 101;
     BtnItem2.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    [BtnItem2 setTitle:@"最热" forState:0];
    [BtnItem2 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0];
    [BtnItem2 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:BtnItem2];

    BtnItem3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [BtnItem3 setFrame:CGRectMake(320/3*2+2, 0, 320/3, 35)];
    BtnItem3.exclusiveTouch=YES;
    BtnItem3.tag = 102;


     BtnItem3.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    [BtnItem3 setTitle:@"最新" forState:0];
    [BtnItem3 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0];
    [BtnItem3 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:BtnItem3];

        [BtnItem1 setTitleColor:[UIColor colorWithRed:1.0 green:.23 blue:.49 alpha:1.0] forState:0];
        [BtnItem2 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0];
        [BtnItem3 setTitleColor:[UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1.0] forState:0];

    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 34, 320, 1)];
    line.image=BundleImage(@"line_01_.png");
    [imageView addSubview:line];
    [line release];
    
    tabBarArrow=[[UIImageView alloc]init];
    tabBarArrow.frame = CGRectMake([self horizontalLocationFor:0], 34, 320/8, 2);
    tabBarArrow.image=BundleImage(@"line_p_.png");
    [imageView addSubview:tabBarArrow];
    [tabBarArrow release];
    }
    return  imageView;
}
//三个按钮事件
-(void)change:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    
    [UIView beginAnimations:Nil context:Nil];
    [UIView setAnimationDuration:0.2];
    CGRect frame=tabBarArrow.frame;
    frame.origin.x=[self horizontalLocationFor:btn.tag-100];
    tabBarArrow.frame=frame;
    [UIView commitAnimations];

    if (btn.tag==100)
    {
        BtnItem1.backgroundColor=[UIColor whiteColor];
        BtnItem2.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        BtnItem3.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        [self initGirdView:0];

    }else if(btn.tag==101)
    {

        BtnItem1.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        BtnItem2.backgroundColor=[UIColor whiteColor];
        BtnItem3.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        [self initGirdView:1];
    }else if(btn.tag==102)
    {
        BtnItem1.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        BtnItem2.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
        BtnItem3.backgroundColor=[UIColor whiteColor];
        [self initGirdView:2];
    }
    
}

-(void)btnTouch:(id)sender
{
    /*
    TMGoodsDetailsViewController *good=[[TMGoodsDetailsViewController alloc]init];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:good animated:YES];
    */
    TMGoodsDetailsViewController *goodsDetail=[[TMGoodsDetailsViewController alloc]init];
    goodsDetail.pid = [sender accessibilityHint];
    //MainViewController *mvc = [[MainViewController alloc]init];
    AppDelegate *app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController pushViewController:goodsDetail animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
