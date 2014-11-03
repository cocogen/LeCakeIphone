//
//  MainLeCakeTableCell.m
//  LeCakeIphone
//
//  Created by David on 14-11-3.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import "MainLeCakeTableCell.h"

@implementation MainLeCakeTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:230.0/255.0 blue:226.0/255.0 alpha:1.0]];
        
        self.leftTitle  = [[UILabel alloc] initWithFrame:CGRectMake(5, 10,100, 15)];
        [self.leftTitle setTextAlignment:NSTextAlignmentLeft];
        [self.leftTitle setFont:[UIFont systemFontOfSize:12.0]];
        [self.leftTitle setTextColor:[UIColor redColor]];
        
        self.rightTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 10,kScreenW-100 - 5, 15)];
        [self.rightTitle setTextAlignment:NSTextAlignmentRight];
        [self.rightTitle setFont:[UIFont systemFontOfSize:12.0]];
        [self.rightTitle setTextColor:[UIColor redColor]];
    
        self.cakeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 25, kScreenW -10, 150 - 25)];
        
        self.cakeTipImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW - 20, 25, 10, 10)];
        
        self.instructionBG = [[UIView alloc] initWithFrame:CGRectMake(5, 150 - 40, kScreenW -10, 40)];
        [self.instructionBG setBackgroundColor:[UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:0.75]];
        
        self.instructionName = [[UILabel alloc] initWithFrame:CGRectMake(10, 150 - 40, kScreenW, 20)];
        [self.instructionName setFont:[UIFont systemFontOfSize:14.0]];
        [self.instructionName setTextAlignment:NSTextAlignmentLeft];
        [self.instructionName setBackgroundColor:[UIColor clearColor]];
        [self.instructionName setTextColor:[UIColor whiteColor]];
        
        self.instructionDetails = [[UILabel alloc] initWithFrame:CGRectMake(10, 150 - 20, kScreenW, 20)];
        [self.instructionDetails setBackgroundColor:[UIColor clearColor]];
        [self.instructionDetails setFont:[UIFont systemFontOfSize:14.0]];
        [self.instructionDetails setTextAlignment:NSTextAlignmentLeft];
        [self.instructionDetails setTextColor:[UIColor whiteColor]];
        
        [self addSubview:self.leftTitle];
        [self addSubview:self.rightTitle];
        [self addSubview:self.cakeImgView];
        [self addSubview:self.cakeTipImgView];
        [self addSubview:self.instructionBG];
        [self addSubview:self.instructionName];
        [self addSubview:self.instructionDetails];
    }
    return self;
}

@end
