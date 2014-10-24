//
//  MoreViewController.m
//  LeCakeIphone
//
//  Created by David on 14-10-21.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import "MoreViewController.h"
#import "NewsDetailViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)init
{
    self = [super init];
	if (self)
	{
        self.title      = @"我的诺心";
        self.showNav    = YES;
        self.resident   = YES;
        [self createTabBarItem:self.title iconImgName:@"tray_menu_more_normal.png" selIconImgName:@"tray_menu_more_highlighted.png"];
        
	}
	return self;
}

- (void)loadUIData
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
