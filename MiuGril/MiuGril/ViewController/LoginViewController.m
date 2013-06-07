//
//  LoginViewController.m
//  MiuGril
//
//  Created by sam on 13-5-28.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SinaWeiboManager.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.view.backgroundColor=[UIColor colorWithRed:243.0/255.0f green:243.0/255.0f blue:243.0/255.0f alpha:1];
    _myScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    _myScrollView.showsHorizontalScrollIndicator=NO;
    _myScrollView.showsVerticalScrollIndicator=NO;
    _myScrollView.pagingEnabled=YES;
    _myScrollView.contentSize=CGSizeMake(320*4, 400);
    _myScrollView.scrollsToTop=NO;
    _myScrollView.delegate=self;
    
    
    UIImageView * imageView1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 404)];
    imageView1.image=[UIImage imageNamed:@"login_1.png"];
    [_myScrollView addSubview:imageView1];
    
    
    
    _spacePageControl=[[SMPageControl alloc] init];
    _spacePageControl.frame=CGRectMake(0, 0, 320, 20);
    _spacePageControl.center=CGPointMake(self.view.center.x, 385);
    _spacePageControl.numberOfPages = 4;
   	[_spacePageControl setPageIndicatorImage:[UIImage imageNamed:@"pageDot"]];
	[_spacePageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"currentPageDot"]];
    
    UIButton * siginBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 410, 100)];
    siginBtn.center=CGPointMake(self.view.center.x, 430);
    [siginBtn setImage:[UIImage imageNamed:@"login_btn.png"] forState:UIControlStateNormal];
    [siginBtn addTarget:self action:@selector(selectSigin:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_myScrollView];
    [self.view addSubview:_spacePageControl];
    [self.view addSubview:siginBtn];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    CGFloat pageWidth=scrollView.frame.size.width;
    int page=floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    _spacePageControl.currentPage=page;

        
}
-(void)selectSigin:(UIButton*)btn{
   

    [SinaWeiboManager siginWeibo];


}

#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    
    [SinaWeiboManager storeAuthData];
    NSMutableDictionary * params=[[NSMutableDictionary alloc] init];
    [params setObject:sinaweibo.userID forKey:@"wid"];
   
    [self.asimanager getDataWithUrl:[NSString stringWithFormat:@"%@%@",MiuGrilAddress,UserSigin] params:params requestType:GET_UserSigin];
}



- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}


-(void)requestFinish:(Request_Type)requestType data:(NSData *)data
{
  
    if(requestType==GET_UserSigin){
        NSLog(@"ok");
    
    }
   
}
@end
