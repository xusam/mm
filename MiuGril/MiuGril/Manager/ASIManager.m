//
//  ASIManager.m
//  ASIManager
//
//  Created by  xu on 8/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import "ASIManager.h"
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Reachability.h"

#import "AppDelegate.h"
#define REQUESTTYPE @"requestType"
@implementation ASIManager
@synthesize delegate=_delegate;
@synthesize requestQueue=_requestQueue;

- (id)initWithDelegate:(id)theDelegate{
    
    self = [super init];
    if (self) {
        requestQueue = [[ASINetworkQueue alloc] init];
        [requestQueue setDelegate:self];
        [requestQueue setRequestDidFailSelector:@selector(requestFailed:)];
        [requestQueue setRequestDidFinishSelector:@selector(requestFinished:)];
        [requestQueue setRequestWillRedirectSelector:@selector(request:willRedirectToURL:)];
		[requestQueue setShouldCancelAllRequestsOnFailure:NO];
        [requestQueue setShowAccurateProgress:YES];
        self.delegate = theDelegate;
        [self start];
    }
    return self;
    
}
-(void)dealloc{

   
    [requestQueue release];
    [super dealloc];
}

#pragma mark - Operate queue
- (BOOL)isRunning
{
	return ![requestQueue isSuspended];
}

- (void)start
{
	if( [requestQueue isSuspended] )
		[requestQueue go];
}

- (void)pause
{
	[requestQueue setSuspended:YES];
}

- (void)resume
{
	[requestQueue setSuspended:NO];
}

- (void)cancel
{
	[requestQueue cancelAllOperations];
}

//通过POST方式获取
/*
 
 NSMutableDictionary * params=[[NSMutableDictionary alloc] init];
 [params setValue:@"" forKey:@""];
 [params setValue:@"" forKey:@""];
 
 */


//通过Get方式获取
- (void)getDataWithUrl:(NSString*)strUrl params:(NSDictionary*)params requestType:(Request_Type)requestType{

    
    //检测网络
    [self checkNetWork];
    
    NSURL  *url = [self generateURL:strUrl params:params];
    
    
    ASIHTTPRequest *item = [[ASIHTTPRequest alloc] initWithURL:url];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:requestType] forKey:REQUESTTYPE];
    [item setUserInfo:dict];
    [dict release];
    
    [requestQueue addOperation:item];
    [item release];
    
    
}
//通过POST方式获取
/*
   NSDictionary * dic1=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"value",@"",@"key", nil];
   NSDictionary * dic2=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"value",@"",@"key", nil];
   NSDictionary * dic3=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"value",@"",@"key", nil];
   NSArray * params=[NSArray arrayWithObjects:dic1,dic2,dic3, nil];
   
 
 */
- (void)postDataWithUrl:(NSString*)strUrl params:(NSArray *)params requestType:(Request_Type)requestType{
    
    //检测网络
    [self checkNetWork];
    
    NSURL *url = [NSURL URLWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    
    [item setRequestMethod:@"POST"];
   
    if (params != nil)
    {
        if (params.count > 0)
        {
            for (NSDictionary *dicPos in params)
            {
                [item setPostValue:[dicPos objectForKey:@"value"]
                               forKey:[dicPos objectForKey:@"key"]];
            }
        }
    }

    item.userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:requestType] forKey:REQUESTTYPE];
    
    [_requestQueue addOperation:item];
   
    [item release];

    
    
}



//失败
- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"requestFailed:%@,%@,",request.responseString,[request.error localizedDescription]);
    if (_delegate == nil) {
        return;
    }
    if([_delegate respondsToSelector:@selector(requestFail:)]){
        
        [_delegate requestFail:[[request.userInfo objectForKey:REQUESTTYPE] intValue]];
    }
    
    
}

//成功
- (void)requestFinished:(ASIHTTPRequest *)request{
    if (_delegate == nil) {
        return;
    }
    if (![ASIManager CheckRequestStatusCode:request.responseStatusCode]){
        return;
    }
    
    [_delegate requestFinish:[[request.userInfo objectForKey:REQUESTTYPE] intValue] data:[request responseData]];
    
    
}

#pragma mark - private method

//URL过滤
- (NSURL*)generateURL:(NSString*)baseURL params:(NSDictionary*)params {
	if (params) {
		NSMutableArray* pairs = [NSMutableArray array];
		for (NSString* key in params.keyEnumerator) {
			NSString* value = [params objectForKey:key];
			NSString* escaped_value = (NSString *)CFURLCreateStringByAddingPercentEscapes(
																						  NULL, /* allocator */
																						  (CFStringRef)value,
																						  NULL, /* charactersToLeaveUnescaped */
																						  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																						  kCFStringEncodingUTF8);
            
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
			[escaped_value release];
		}
		
		NSString* query = [pairs componentsJoinedByString:@"&"];
		NSString* url = [NSString stringWithFormat:@"%@?%@", baseURL, query];
		return [NSURL URLWithString:url];
	} else {
		return [NSURL URLWithString:baseURL];
	}
}

//检测返回代码
+ (BOOL)CheckRequestStatusCode:(int )StatusCode
{
    BOOL bResult = NO;
    switch (StatusCode)
    {
        case 200: // OK: Success!
            bResult = YES;
			break;
            
        case 304: // Not Modified: there was no new data to return.
            bResult = NO;
            break;
            
        case 401: // Not Authorized: either you need to provide authentication credentials, or the credentials provided aren't valid.
			bResult = NO;
            break;
            
        case 400: // Bad Request: your request is invalid, and we'll return an error message that tells you why. This is the status code returned if you've exceeded the rate limit
			bResult = NO;
            break;
            
        case 403: // Forbidden: we understand your request, but are refusing to fulfill it.  An accompanying error message should explain why.
            bResult = NO;
            break;
			
        case 404: // Not Found: either you're requesting an invalid URI or the resource in question doesn't exist (ex: no such user).
		{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
																message:@"404错误,请与管理员联系"
															   delegate:nil
													  cancelButtonTitle:@"确认" otherButtonTitles:nil];
			[alertView show];
			[alertView release];
		}
			break;
        case 500: // Internal Server Error: we did something wrong.  Please post to the group about it and the Weibo team will investigate.
            bResult = NO;
            break;
            
        case 502: // Bad Gateway: returned if Weibo is down or being upgraded.
            bResult = NO;
            break;
            
        case 503: // Service Unavailable: the Weibo servers are up, but are overloaded with requests.  Try again later.
		{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
																message:@"503错误,请与管理员联系"
															   delegate:nil
													  cancelButtonTitle:@"确认" otherButtonTitles:nil];
			[alertView show];
			[alertView release];
		}
        default:
			bResult = NO;
            break;
    }
    
    return bResult;
}

//检测网络
- (void)checkNetWork
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        
       /*
        检测不存在网络，给予提示
        
        建议调用方法写在AppDelegate.h 方便全局调用
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        */
        

     
        return;
    }
}


@end
