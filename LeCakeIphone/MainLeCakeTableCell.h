//
//  MainLeCakeTableCell.h
//  LeCakeIphone
//
//  Created by David on 14-11-3.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefine.h"

@interface MainLeCakeTableCell : UITableViewCell
@property (nonatomic,strong)UILabel * leftTitle;
@property (nonatomic,strong)UILabel * rightTitle;
@property (nonatomic,strong)UIImageView * cakeImgView;
@property (nonatomic,strong)UIImageView * cakeTipImgView;
@property (nonatomic,strong)UIView      * instructionBG;
@property (nonatomic,strong)UILabel     * instructionName;
@property (nonatomic,strong)UILabel     * instructionDetails;
@end
