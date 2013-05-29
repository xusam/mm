//
//  SXDataTableView.h
//  SXDataTableView
//
//  Created by  xu on 11/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIManager.h"
#import "EGORefreshTableHeaderView.h"
@class SXBottomView;

@interface SXDataTableView : UIView<UITableViewDataSource,ASIManagerDelegate,EGORefreshTableHeaderDelegate>{

    ASIManager * _asimanager;
    int  _intCurrentRowEdit;
    NSString *_CellClassName;
    
	BOOL _reloading;
   
}
@property(nonatomic,readonly)NSMutableArray * arrData;//服务器获取的数据
@property(nonatomic, readonly)UITableView *tableView;
@property(nonatomic, assign)BOOL canBeEdit;//是否编辑状态
@property(nonatomic, assign)BOOL isMorePage; //还有页面可以加载
@property(nonatomic, assign)BOOL isFistShow; //默认YES，（用于第一次显示后，设它为NO）
@property(nonatomic, assign)BOOL isAlreadyRequetsed; //为YES时，上页请求已完成，用于避免同一页多次请求
@property(nonatomic, assign)NSInteger iPageCurrent;  //当前页码
@property(nonatomic, retain)SXBottomView *bottomView;  //加载更多显示View
@property(nonatomic,retain)EGORefreshTableHeaderView *refreshHeaderView;
- (id)initWithFrame:(CGRect)frame andCellClass:(NSString *)className;//初始化
//请求服务端


//多页加载（默认不显示）
- (BOOL)TableViewDidScroll:(UIScrollView *)scrollView;//拖动事件，触发加载更多
-(BOOL)requestPageBegin;//判断是否符合条件，才能访问服务端

-(void)requestFinishB2SCurrentPage:(int)PageNumber TotalPage:(int)PageCount;//判断页码是否最后一页,页码自定义

-(void)requestFinishS2CCurrentPage:(int)PageNumber TotalPage:(int)PageCount;//判断页码是否最后一页,页码服务端

//下拉刷新方法
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end
