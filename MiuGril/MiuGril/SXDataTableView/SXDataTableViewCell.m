//
//  SXDataTableViewCell.m
//  SXDataTableView
//
//  Created by  xu on 11/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import "SXDataTableViewCell.h"

@implementation SXDataTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)ShowCellWithData:(NSDictionary *)dic;
{
    
}


@end
