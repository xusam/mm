//
//  CenterCell.m
//  MiuGril
//
//  Created by sam on 13-5-22.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import "CenterCell.h"
#import "SamUtil.h"
@implementation CenterCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"xxxxxxx");

        self.selectionStyle=UITableViewCellAccessoryNone;
        UIImageView * content_bg=[[UIImageView alloc] init];
        [SamUtil initImageView:content_bg Frame:CGRectMake(5, 5, 310, 400) andImage:[UIImage imageNamed:@"content_bg2.png"]];
        
        _praisePic=[[UIImageView alloc] init];
        [SamUtil initImageView:_praisePic Frame:CGRectMake(10, 375, 18, 18) andImage:[UIImage imageNamed:@"share_1.png"] ];
        
        UIButton * sharebtn=[[UIButton alloc] init];
        [SamUtil initButton:sharebtn image:[UIImage imageNamed:@"content_more.png"] Frame:CGRectMake(263, 377, 74/2, 26/2) addTarget:self action:@selector(showShare)];
        
        
        content_bg.userInteractionEnabled=YES;
        _headPic=[[UIButton alloc] init];
        _nickname=[[UILabel alloc] init];
        _contentPic=[[UIImageView alloc] init];
        _createTime=[[UILabel alloc] init];
        _praiseCount=[[UILabel alloc] init];
        
        
        [content_bg addSubview:_headPic];
        [content_bg addSubview:_nickname];
        [content_bg addSubview:_contentPic];
        [content_bg addSubview:_createTime];
        [content_bg addSubview:_praiseCount];
        [content_bg addSubview:_praisePic];
        [content_bg addSubview:sharebtn];
        [self addSubview:content_bg];

    }
    return self;
}


-(void)ShowCellWithData:(NSDictionary *)dic;
{
 
    
    [SamUtil initButton:_headPic image:nil Frame:CGRectMake(10, 10, 33, 33) addTarget:self action:@selector(showUserInfo)];
    
    [_headPic setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"user_pic"]] forState:UIControlStateNormal];
    [SamUtil initLabel:_nickname text:[dic objectForKey:@"nickname"] Frame:CGRectMake(53, 18, 200, 20) size:14 blod:YES color:[UIColor colorWithRed:51/250.0f green:180/250.0f blue:225/250.0f alpha:1]];
    
    [SamUtil initImageView:_contentPic Frame:CGRectMake(10, 50, 290, 320) andImage:nil cornerRadius:3];
    [_contentPic setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"bmiddle_pic"]] placeholderImage:nil];
    _contentPic.contentMode= UIViewContentModeScaleAspectFill;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelTap)];
    tap.numberOfTapsRequired=2;
    [_contentPic addGestureRecognizer:tap];
    _contentPic.userInteractionEnabled=YES;
    
    
    [SamUtil initLabel:_praiseCount text:[NSString stringWithFormat:@"%@ 条称赞",[dic objectForKey:@"praise_count"]] Frame:CGRectMake(33, 376, 200, 18) size:13 blod:YES color:[UIColor colorWithRed:51/250.0f green:180/250.0f blue:225/250.0f alpha:1]];
    
    
    
}

-(void)showUserInfo{


    NSLog(@"show");
}
-(void)handelTap{

    [_praisePic setImage:[UIImage imageNamed:@"share_2.png"]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showPariseHeart" object:nil];

}
-(void)showShare{

    NSLog(@"show");

}
@end
