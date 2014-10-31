//
//  PersonOrderViewController.m
//  LeCakeIphone
//
//  Created by David on 14-10-31.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import "PersonOrderViewController.h"

@interface PersonOrderViewController ()

@end

@implementation PersonOrderViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title      = @"订制";
        self.showNav    = YES;
        self.resident   = YES;
        [self createTabBarItem:self.title iconImgName:@"tray_menu_mystock_normal.png" selIconImgName:@"tray_menu_mystock_highlighted.png"];
        
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
