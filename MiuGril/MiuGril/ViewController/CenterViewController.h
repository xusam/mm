//
//  CenterViewController.h
//  MiuGril
//
//  Created by sam on 13-5-22.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterCell.h"
#import "BaseViewController.h"
@class SXDataTableView;

@interface CenterViewController : BaseViewController<UITableViewDelegate>{

   SXDataTableView * _sxDataTableView;
   
    //测试 test
    NSArray * _dataList;
    int pageIndex;
    
    
}
-(void)fristRequest;  
@end
