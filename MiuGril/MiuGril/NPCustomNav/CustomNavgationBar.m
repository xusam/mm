//
//  CustomNavgationBar.m
//  GuRuGamePlatform
//
//  Created by QQ：328260200 徐贤 on 12-9-19.
//  Copyright (c) 2012年 x. All rights reserved.
//

#import "CustomNavgationBar.h"

@implementation UINavigationBar (CustomBackgroud)  

// iOS 4.* 下替换导航条皮肤  
- (void)drawRect:(CGRect)rect  
{  
    UIImage *navBarImg = [UIImage imageNamed:@"nav_bg.png"] ; 
    [navBarImg drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];  
}  

-(UIImage*)barBackground
{
    return[UIImage imageNamed:@"nav_bg.png"];
}

-(void)didMoveToSuperview
{
    //如果只支持IOS5，需要把判断去掉
    if([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self setBackgroundImage:[self barBackground] forBarMetrics:UIBarMetricsDefault];
    }
}

@end  
