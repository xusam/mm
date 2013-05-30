//
//  SamUtil.h
//  MiuGril
//
//  Created by sam on 13-5-22.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface SamUtil : NSObject



+(void)initImageView:(UIImageView*)imageView Frame:(CGRect)rect andImage:(UIImage*)image;

+(void)initImageView:(UIImageView*)imageView Frame:(CGRect)rect andImage:(UIImage*)image cornerRadius:(int)cornerRadius ;


+(void)initButton:(UIButton*)btn image:(UIImage*)image Frame:(CGRect)rect addTarget:(id)target  action:(SEL)action;

+(void)initLabel:(UILabel*)label text:(NSString*)text Frame:(CGRect)rect size:(int)size
blod:(BOOL)blod color:(UIColor*)color;

+(UIBarButtonItem*)getBarButtonItem:(UIButton*)button;


@end
