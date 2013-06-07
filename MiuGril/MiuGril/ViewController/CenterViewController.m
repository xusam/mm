//
//  CenterViewController.m
//  MiuGril
//
//  Created by sam on 13-5-22.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import "CenterViewController.h"
#import "SXDataTableView.h"
#import "SXDataTableViewCell.h"
#import "MiuGrilStatic.h"
#import "CJSONDeserializer.h"
#import "CenterCell.h"
#import "SamUtil.h"
#import "SinaWeiboManager.h"
#import "JSONKit.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

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
    pageIndex=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPariseHeart) name:@"showPariseHeart" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showUserInfo) name:@"showUserInfo" object:nil];
    self.view.backgroundColor=[UIColor colorWithRed:243.0/255.0f green:243.0/255.0f blue:243.0/255.0f alpha:1];
    

    
    _sxDataTableView=[[SXDataTableView alloc] initWithFrame:CGRectMake(0, 0, 320, MM_VIEW_HEIGT) andCellClass:[NSString stringWithFormat:@"%@",[CenterCell class]]];
    
    _sxDataTableView.tableView.delegate=self;
    
    
    [self.view addSubview:_sxDataTableView];
    
   
    
    

    
    [self fristRequest];
    
	// Do any additional setup after loading the view.
}

-(void)fristRequest{
    NSMutableDictionary * params=[[NSMutableDictionary alloc] init];
    [params setValue:[SinaWeiboManager getWid] forKey:@"uid"];
    [params setValue:[NSString stringWithFormat:@"%d",pageIndex] forKey:@"pageIndex"];
    
    [self.asimanager getDataWithUrl:[NSString stringWithFormat:@"%@%@",MiuGrilAddress,GetMiuGril] params:params requestType:GET_MiuGril];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 410;
}

-(void)showPariseHeart{

    CABasicAnimation *opacityAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation1.fromValue        = [NSNumber numberWithFloat:1.0f];
    opacityAnimation1.toValue = [NSNumber numberWithFloat:0.5f];
    opacityAnimation1.duration        = 1.0;
    opacityAnimation1.beginTime = 0.5f;
    opacityAnimation1.removedOnCompletion = NO;
    opacityAnimation1.fillMode = kCAFillModeForwards;
    opacityAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *opacityAnimation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation2.fromValue        = [NSNumber numberWithFloat:0.5f];
    opacityAnimation2.toValue = [NSNumber numberWithFloat:0.0f];
    opacityAnimation2.duration        = 0.5;
    opacityAnimation2.beginTime = 1.0f;
    opacityAnimation2.removedOnCompletion = NO;
    opacityAnimation2.fillMode = kCAFillModeForwards;
    opacityAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:opacityAnimation1, opacityAnimation2, nil];
    groupAnimation.duration = 1.5f;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    
    UIImageView *praiseHeart = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heart.png"]];
    
    praiseHeart.frame = CGRectMake(0, 0, 140.0f/2, 140.0f/2);
    praiseHeart.center=CGPointMake(self.view.center.x, self.view.center.y-40);
    [self.view addSubview:praiseHeart];
    
    
    
    [praiseHeart.layer addAnimation:groupAnimation forKey:nil];
    

}

-(void)requestFinish:(Request_Type)requestType data:(NSData *)data{


    if(requestType==GET_MiuGril){
        NSDictionary* result=   [data objectFromJSONDataWithParseOptions:JKParseOptionStrict];
        NSLog(@"%@",result);
        NSArray* arrData=[result objectForKey:@"datas"];
        [_sxDataTableView.arrData addObjectsFromArray:arrData];
        [_sxDataTableView.tableView reloadData];
        
    }
}
@end
