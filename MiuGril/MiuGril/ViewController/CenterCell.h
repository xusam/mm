//
//  CenterCell.h
//  MiuGril
//
//  Created by sam on 13-5-22.
//  Copyright (c) 2013年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXDataTableViewCell.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"




@interface CenterCell : SXDataTableViewCell{

    UIButton    *_headPic;
    UILabel        *_nickname;
    UILabel        *_createTime;
    UILabel        *_praiseCount;
    UIImageView    *_contentPic;
    UIImageView   * _praisePic;
    
    
    

}


@end
