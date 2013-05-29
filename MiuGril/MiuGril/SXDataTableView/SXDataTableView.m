//
//  SXDataTableView.m
//  SXDataTableView
//
//  Created by  xu on 11/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import "SXDataTableView.h"
#import "SXBottomView.h"
#import "SXDataTableViewCell.h"
#import "CJSONDeserializer.h"
@implementation SXDataTableView
@synthesize arrData = _arrData;//这里只有一个section,是一维的数据
@synthesize tableView = _tableView;
@synthesize canBeEdit = _canBeEdit;
@synthesize refreshHeaderView=_refreshHeaderView;


//=== 多页加载
@synthesize isMorePage = _isMorePage; //还有页面可以加载
@synthesize isFistShow = _isFistShow; //默认YES，（用于第一次显示后，设它为NO）
@synthesize isAlreadyRequetsed = _isAlreadyRequetsed; //为YES时，上页请求已完成，用于避免同一页多次请求
@synthesize iPageCurrent = _iPageCurrent;
@synthesize bottomView = _bottomView;

- (void)dealloc
{
    _asimanager.delegate = nil;
  
    [_asimanager release];
    
    [_CellClassName release];
    

    
    [_arrData removeAllObjects];
    [_arrData release];//这里只有一个section,是一维的数据
    [_tableView release];
    
    _bottomView = nil;
    
    [super dealloc];
}

//初始化
- (id)initWithFrame:(CGRect)frame andCellClass:(NSString *)className{
    self = [super initWithFrame:frame];
    if (self)
    {
        _CellClassName = [[NSString alloc] initWithString:className];
        
        //可编辑参数
        _canBeEdit = NO;
        _intCurrentRowEdit = 0;
        
        // Initialization code
        CGRect frameTable = frame;
        frameTable.origin = CGPointMake(0.0f, 0.0f);
        
        _isFistShow = YES;
        _asimanager = [[ASIManager alloc] initWithDelegate:self];
       
        
        
        _arrData = [[NSMutableArray alloc] init];
        [_arrData removeAllObjects];
        
        _tableView = [[UITableView alloc] initWithFrame:frameTable];
        _tableView.dataSource = self;
        [_tableView reloadData];
        
        _bottomView = nil;
   
        [self setBackgroundColor:[UIColor clearColor]];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        
        
        //下拉刷新
        if (_refreshHeaderView == nil) {
            
            EGORefreshTableHeaderView *headView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _tableView.bounds.size.height, frame.size.width, _tableView.bounds.size.height)];
            headView.delegate = self;
            [self.tableView addSubview:headView];
            _refreshHeaderView = headView;
            [headView release];
            
        }
        
        [_refreshHeaderView refreshLastUpdatedDate];
        
        
        
        [self addSubview:_tableView];
        
        


        
 
    }
    return self;
    
}


//*************************tableview操作方法 ***********************//

//多页加载（默认不显示）//拖动事件，触发加载更多

/*
 在UITableViewDelegate执行者中调用scrollViewDidScroll判断是否拖动范围
 -(void)scrollViewDidScroll:(UIScrollView *)scrollView
 {
 if ([scrollView isEqual:_tableView])
 {
  
 }
 }
 */
- (BOOL)TableViewDidScroll:(UIScrollView *)scrollView{
    BOOL bResult = NO;
    if (scrollView.contentOffset.y + self.frame.size.height - 60 > scrollView.contentSize.height)
    {
        bResult = YES;
    }
    
    return  bResult;

}

//判断是否符合条件，才能访问服务端
/*
 注意：在每一个请求都需要判断一次 做一个严密的判断
 1.在编辑状态不能访问服务端
 2.在已经请求状态不能访问服务端
 3.已经是最后一页不能访问服务端
 
 */
-(BOOL)requestPageBegin{
    BOOL bResult = NO;

    if (_isAlreadyRequetsed && !_tableView.isEditing && _isMorePage) //
    {
        if (_bottomView != nil) //默认它为nil
            [_bottomView setState:SXBottomViewState_Loading];
        
        _isAlreadyRequetsed = NO;
        bResult = YES;
    }else{
        
        
    }
 
    
    return bResult;
}

//判断页码是否最后一页,页码自定义
/*
 使用在请求成功，委托requestFinish中使用
 获取服务端返回的页码总数
 
 */
-(void)requestFinishB2SCurrentPage:(int)PageNumber TotalPage:(int)PageCount{

    if (PageNumber < PageCount)
    {
        if (_bottomView == nil) //默认它为nil
        {
            _bottomView = [[SXBottomView alloc] init];
        }
        
        _isMorePage = YES;
    }
    else
        _isMorePage = NO;//避免请求超过页数的数据
    
    
    _isAlreadyRequetsed = YES;
    [_bottomView setState:SXBottomViewState_Normal];
    [_tableView reloadData];

}

//判断页码是否最后一页,页码服务端
-(void)requestFinishS2CCurrentPage:(int)PageNumber TotalPage:(int)PageCount{
    if (PageNumber > PageCount)
    {
        if (_bottomView == nil) //默认它为nil
        {
            _bottomView = [[SXBottomView alloc] init];
        }
        
        _isMorePage = YES;
    }
    else
        _isMorePage = NO;//避免请求超过页数的数据
    
    
    _isAlreadyRequetsed = YES;
    [_bottomView setState:SXBottomViewState_Normal];
    [_tableView reloadData];

}
//清除所有数据
-(void)removeAllData{
    
    [_arrData removeAllObjects];
    [_tableView reloadData];
    
}

//*************************tableviewData delegate ***********************//
#pragma mark - Table view data source



-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row)
    {
        //end of loading
        //for example [activityIndicator stopAnimating];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES if you want the specified item to be editable.
    return _canBeEdit;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSLog(@"numberOfSectionsInTableView: 1");
    return 1;
}


/*
 如果有更多页，arrData条数+1
 
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView])
    {
        
        if(_bottomView!= nil && _isMorePage)
        {
            NSLog(@"origin count %d", _arrData.count + 1);
            return (_arrData.count + 1);
        }else
        {
            return _arrData.count;
        }
    }
    return 0;
}



/*

 
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    @try
    {
        //========= 加载View ==========
        if (indexPath.row == _arrData.count && _bottomView != nil && _isMorePage)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"bottomView"];
            
            if (cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:@"bottomView"] autorelease];
                UIImageView *selectcellgb=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgSelectedCell.png"]];
                [cell setSelectedBackgroundView:selectcellgb];
                [selectcellgb release];
            }
            
            
            if (cell != nil)
            {
                for (UIView *view in cell.contentView.subviews) {
                    [view removeFromSuperview];
                }
                [cell setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0f)];
                [cell.contentView addSubview:_bottomView];
            }
            
        }
        
        //=========数据Cell ==========
        else if (_arrData.count > 0 && indexPath.row < _arrData.count)
        {
           
            
            cell = [tableView dequeueReusableCellWithIdentifier:_CellClassName];
            NSObject *Dataobject = [_arrData objectAtIndex:indexPath.row];
            
            if (cell == nil)
            {
                if ([Dataobject isKindOfClass: [NSDictionary class]])
                {
                    Class theClass = NSClassFromString(_CellClassName);
                    NSObject* CellObject = [[[theClass performSelector:@selector(alloc)] initWithStyle:UITableViewCellStyleDefault
                                                                                       reuseIdentifier:_CellClassName] autorelease];
                    
                    
                    if ([CellObject isKindOfClass:[SXDataTableViewCell class]])
                    {
                        cell = (SXDataTableViewCell *)CellObject;
                        
                    }
                }
            }
            
            if (   [Dataobject isKindOfClass: [NSDictionary class]]
                && [cell isKindOfClass:[SXDataTableViewCell class]])
            {
                [(SXDataTableViewCell *)cell ShowCellWithData:(NSDictionary *)Dataobject];
            }
            
        }
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"customTableView cellForRowAtIndexPath exception %@", exception.reason);
    }
    
    return cell;
}



#pragma mark - table view edit data source

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//*************************数据访问***********************//
#pragma makr -  Http Request

-(void)getRequestDataWithUrl:(NSString*)strUrl params:(NSDictionary*)data requestType:(Request_Type)requestType{

    [_asimanager getDataWithUrl:strUrl params:data requestType:requestType];
}

-(void)postRequestDataWithUrl:(NSString*)strUrl params:(NSArray*)dataList requestType:(Request_Type)requestType{

    [_asimanager postDataWithUrl:strUrl params:dataList requestType:requestType];
}

#pragma mark - ASIRequestHttp  Delegate

-(void)requestFinish:(Request_Type)requestType data:(NSData *)data{

    NSError * theError;
    _isAlreadyRequetsed=YES;
    id theObject = [[CJSONDeserializer deserializer] deserialize:data error:&theError];
    
    [self fillDataWithJsonData:theObject requestType:requestType];
    

}
//让继承者重写些方法，
-(void)fillDataWithJsonData:(id)jsonData requestType:(Request_Type)requestType{

       

}


-(void)requestFail:(Request_Type)requestType{



}

//*************************下拉刷新***********************//
#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}
/*
//在使用Uitableview.delegate者的中调用，触发下拉刷新 
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

*/

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}



@end
