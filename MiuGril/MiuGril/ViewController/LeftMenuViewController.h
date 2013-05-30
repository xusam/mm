//
//  LeftMenuViewController.h
//  MiuGril
//
//  Created by sam on 13-5-22.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface LeftMenuViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * menuTableView;

}

@end
