//
//  MainViewController.h
//  LeCakeIphone
//
//  Created by David on 14-10-21.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import "CMViewController.h"
#import "CycleScrollView.h"

@interface MainViewController : CMViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView   * cakeListTable;// 主要table
@property (nonatomic, strong) CycleScrollView *mainScorllView;//滑动广告
@end
