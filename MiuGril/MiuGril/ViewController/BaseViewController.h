//
//  BaseViewController.h
//  MiuGril
//
//  Created by sam on 13-5-30.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIManager.h"
@interface BaseViewController : UIViewController<ASIManagerDelegate>


@property(nonatomic,retain)ASIManager *asimanager;
@end
