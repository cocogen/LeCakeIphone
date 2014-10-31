//
//  MainViewController.h
//  LeCakeIphone
//
//  Created by David on 14-10-21.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import "CMViewController.h"
#import "CycleScrollView.h"

@interface MainViewController : CMViewController
@property (nonatomic,strong)UITableView * mianTable;// 主要table
@property (nonatomic , retain) CycleScrollView *mainScorllView;
@end
