//
//  SinaWeiboManager.h
//  MiuGril
//
//  Created by sam on 13-5-30.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SinaWeibo;
@interface SinaWeiboManager : NSObject


+(SinaWeibo*)getSinaWeibo;
+(void)storeAuthData;
+(void)removeAuthData;
+(void)siginWeibo;
@end
