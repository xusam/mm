//
//  AppDelegate.h
//  MiuGril
//
//  Created by sam on 13-5-22.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiuGrilStatic.h"
@class ViewController;
@class SinaWeibo;
@class LoginViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LoginViewController *viewController;

@property (retain, nonatomic) SinaWeibo *sinaweibo;
@end
