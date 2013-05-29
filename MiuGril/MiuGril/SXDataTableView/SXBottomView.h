//
//  Bottom.h
//  SXDataTableView
//
//  Created by  xu on 11/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    SXBottomViewState_Pulling=0,
    SXBottomViewState_Normal,
    SXBottomViewState_Loading,
} SXBottomViewState;
@interface SXBottomView : UIView{
  
    SXBottomViewState _state;
    UILabel *_lalStatus;
    UIActivityIndicatorView *_activityView;

}
//设置按钮的状态
- (void)setState:(SXBottomViewState)aState;
@end
