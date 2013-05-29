//
//  ASIManager.h
//  ASIManager
//
//  Created by  xu on 8/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ASIFormDataRequest;
@class ASIHTTPRequest;
@class ASINetworkQueue;

typedef enum {
    GET_TEST=0,

}Request_Type;

@protocol ASIManagerDelegate <NSObject>

-(void)requestFinish:(Request_Type)requestType data:(NSData*)data;
-(void)requestFail:(Request_Type)requestType ;


@end

@interface ASIManager : NSObject
{

    id<ASIManagerDelegate>  delegate;
    ASINetworkQueue* requestQueue;

}
@property(nonatomic,assign)id<ASIManagerDelegate> delegate;
@property(nonatomic,retain)ASINetworkQueue * requestQueue;

//初始化
- (id)initWithDelegate:(id)theDelegate;

//通过Get方式获取
- (void)getDataWithUrl:(NSString*)strUrl params:(NSDictionary*)params requestType:(Request_Type)requestType;

//通过POST方式获取
- (void)postDataWithUrl:(NSString*)strUrl  params:(NSArray *)params requestType:(Request_Type)requestType;

@end
