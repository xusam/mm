//
//  RecommendViewController.m
//  MiuGril
//
//  Created by sam on 13-5-30.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import "RecommendViewController.h"
#import "CJSONDeserializer.h"
#import "SamUtil.h"
#import "UIImageView+WebCache.h"
#import "SelectButton.h"
@interface RecommendViewController ()

@end

@implementation RecommendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIButton * rightNavBtn=[[UIButton alloc] init];
        [rightNavBtn addTarget:self action:@selector(showRight:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem=[SamUtil getBarButtonItem:rightNavBtn];
    }
    return self;
}
-(void)showRight:(UIButton*)btn{

    NSLog(@"OK");

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"推介";
    //测试 test ---------------------
    NSString *path = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"json"];
    
    NSData *jsonData = [[NSFileManager defaultManager] contentsAtPath:path];
    
    NSDictionary * data= [[CJSONDeserializer deserializer] deserialize:jsonData error:nil];
    NSArray *array=[data objectForKey:@"dataList"];
    
    for(int i=0;i<3;i++){
        
        for(int j=0;j<3;j++){
            
            int  row=i+j+2*i;
            NSDictionary * dic=[array objectAtIndex:row];
            UIImageView * headPic=[[UIImageView alloc] init];
            
            [SamUtil initImageView:headPic Frame:CGRectMake(8+(95+9)*j, 10+(95+40)*i, 95, 95) andImage:nil cornerRadius:95/2.0f];
            [headPic setImageWithURL:[dic objectForKey:@"bmiddle_pic"]];
            
            
            UIImageView *headPic_bg=[[UIImageView alloc] init];
            [SamUtil initImageView:headPic_bg Frame:CGRectMake(5+(101+3)*j, 8+(101+34)*i, 101, 101) andImage:[UIImage imageNamed:@"headpic_bg.png"]];
            
            SelectButton * follow_btn=[[SelectButton alloc] initWithFrame:CGRectMake(0, 0, 80/2.0f, 45/2.0f)];
        
            follow_btn.tag=row;
            follow_btn.center=CGPointMake(headPic.center.x, headPic.center.y+65);
            [follow_btn setImage:[UIImage imageNamed:@"follow_btn_normal@2x.png"] forState:UIControlStateNormal];
            [follow_btn addTarget:self action:@selector(selectFollowBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            [self.view addSubview:headPic];
            [self.view addSubview:headPic_bg];
            [self.view addSubview:follow_btn];
        
        }

    }
	
    
}


-(void)selectFollowBtn:(UIButton*)btn{

    SelectButton *selectBtn=(SelectButton*)btn;
    
    [selectBtn setNormalImage:[UIImage imageNamed:@"follow_btn_normal@2x.png"] actionImage:[UIImage imageNamed:@"follow_btn_action@2x.png"] ];



}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
