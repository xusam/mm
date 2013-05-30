//
//  SelectButton.h
//  MiuGril
//
//  Created by sam on 13-5-30.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectButton : UIButton{

    BOOL _selected;

}


-(void)setNormalImage:(UIImage *)normalImage actionImage:(UIImage*)actionImage ;
@end
