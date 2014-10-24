//
//  MainViewController.m
//  LeCakeIphone
//
//  Created by David on 14-10-21.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import "MainViewController.h"
#import "NewsDetailViewController.h"
#import "LoginViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)init
{
    self = [super init];
	if (self)
	{
        self.title      = @"蛋糕时刻";
        self.showNav    = YES;
        self.resident   = YES;
        [self createTabBarItem:self.title iconImgName:@"tray_menu_home_normal.png" selIconImgName:@"tray_menu_home_highlighted.png"];
        
	}
	return self;
}


- (void)loadUIData
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100, 200, 80, 80)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"Login" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor blackColor]];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)btnAction:(id)sender
{
    LoginViewController * ndVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:ndVC animated:YES];
    [self setHiddenTabBarView:YES];
}




//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setHiddenTabBarView:NO];
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
