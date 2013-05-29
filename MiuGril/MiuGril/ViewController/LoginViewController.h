//
//  LoginViewController.h
//  MiuGril
//
//  Created by sam on 13-5-28.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
@interface LoginViewController : UIViewController<UIScrollViewDelegate,SinaWeiboDelegate, SinaWeiboRequestDelegate>

{

     UIScrollView * _myScrollView;
     UIPageControl * _pageControl;
     SMPageControl *_spacePageControl;

}
@end
