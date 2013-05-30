//
//  SinaWeiboManager.m
//  MiuGril
//
//  Created by sam on 13-5-30.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import "SinaWeiboManager.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
@implementation SinaWeiboManager


+(SinaWeibo*)getSinaWeibo{

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;


}

+(void)storeAuthData{
    SinaWeibo *sinaweibo = [self getSinaWeibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(void)removeAuthData{

[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];

}
+(void)siginWeibo{
    SinaWeibo *sinaweibo = [self getSinaWeibo];
    [sinaweibo logIn];


}
@end
