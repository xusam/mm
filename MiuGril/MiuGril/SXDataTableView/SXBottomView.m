//
//  Bottom.m
//  SXDataTableView
//
//  Created by  xu on 11/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import "SXBottomView.h"

@implementation SXBottomView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    self.backgroundColor = [UIColor clearColor];
        _lalStatus = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        _lalStatus.textAlignment = NSTextAlignmentCenter;
        _lalStatus.backgroundColor =  [UIColor clearColor];
        //[_lalStatus setText:@"加载更多"];
        
        
        _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityView setFrame:CGRectMake(250, 0, 50, 50)];
        [_activityView stopAnimating];
        //[_activityView setHidden:NO];
        
        [self addSubview:_lalStatus];
        [self addSubview:_activityView];
    }
    return  self;
}




#pragma mark -

- (void)setState:(SXBottomViewState)aState
{
    switch (aState) {
        case SXBottomViewState_Pulling:
			_lalStatus.text = @"加载更多";
            
			break;
            
		case SXBottomViewState_Normal:
			_lalStatus.text = @"加载更多";
			[_activityView stopAnimating];
			break;
            
		case SXBottomViewState_Loading:
            _lalStatus.text = @"正在加载，请稍等";
			[_activityView startAnimating];
			break;
            
		default:
			break;
    }
    _state = aState;
}


@end
