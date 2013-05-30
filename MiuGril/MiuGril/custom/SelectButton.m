//
//  SelectButton.m
//  MiuGril
//
//  Created by sam on 13-5-30.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import "SelectButton.h"

@implementation SelectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _selected=NO;
    }
    return self;
}
-(id)init{


    self=[super init];
    if(self){
     _selected=NO;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)setNormalImage:(UIImage *)normalImage actionImage:(UIImage*)actionImage {

    if(_selected==YES){
      _selected=NO;
        [self setImage:normalImage forState:UIControlStateNormal];
        
    }else{
    _selected=YES;
     [self setImage:actionImage forState:UIControlStateNormal];
    }




}
@end
