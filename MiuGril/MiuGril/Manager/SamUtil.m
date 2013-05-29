//
//  SamUtil.m
//  MiuGril
//
//  Created by sam on 13-5-22.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import "SamUtil.h"

@implementation SamUtil
+(void)initImageView:(UIImageView*)imageView Frame:(CGRect)rect andImage:(UIImage*)image{


    imageView.image=image;
    imageView.frame=rect;

}
+(void)initImageView:(UIImageView*)imageView Frame:(CGRect)rect andImage:(UIImage*)image cornerRadius:(int)cornerRadius {

    imageView.image=image;
    imageView.frame=rect;
    imageView.layer.cornerRadius = cornerRadius;
    imageView.layer.masksToBounds = YES;


}
+(void)initButton:(UIButton*)btn image:(UIImage*)image Frame:(CGRect)rect addTarget:(id)target  action:(SEL)action {

    btn.frame=rect;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];


}
+(void)initLabel:(UILabel*)label text:(NSString*)text Frame:(CGRect)rect size:(int)size
            blod:(BOOL)blod color:(UIColor*)color{
    label.text=text;
    label.backgroundColor=[UIColor clearColor];
    label.frame=rect;
    if(blod){
    
        label.font=[UIFont boldSystemFontOfSize:size];
    }else{
    
        label.font=[UIFont systemFontOfSize:size];
    }
    label.textColor=color;

}
@end
