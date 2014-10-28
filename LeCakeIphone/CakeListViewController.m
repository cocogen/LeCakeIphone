//
//  CakeListViewController.m
//  LeCakeIphone
//
//  Created by David on 14-10-21.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import "CakeListViewController.h"


@interface CakeListViewController ()
- (UIView *)setCakeListTitleBar;
@end

@implementation CakeListViewController

- (id)init
{
    self = [super init];
	if (self)
	{
        self.title      = @"蛋糕馆";
        self.showNav    = YES;
        self.resident   = YES;
        [self createTabBarItem:self.title iconImgName:@"tray_menu_market_normal.png" selIconImgName:@"tray_menu_market_highlighted.png"];
        
	}
	return self;
}

- (void)loadUIData
{
    [self setCakeListTitleBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)setCakeListTitleBar
{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 33)];
    [scrollView setContentSize:CGSizeMake(kScreenW + 100, 33)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.bounces = YES;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW + 100, 33)];
    imageView.image = [CommonDrawFunc retinaImageNamed:@"headerTitleBg.png"];
    imageView.userInteractionEnabled = YES;
//    [self.view addSubview:imageView];
    
    
    NSArray * titleArray = [NSArray arrayWithObjects:
                            kCakeHomeItemAllTitle,
                            kCakeHomeItemZSTitle,
                            kCakeHomeItemMSTitle,
                            kCakeHomeItemQKLTitle,
                            kCakeHomeItemNPLTitle, nil];
    
    self.customSegmentCtl = [[CustomSegmentControl alloc] initWithFrame:imageView.bounds
                                                    titleItems:titleArray
                                               backgroundColor:[UIColor clearColor]
                                                   itemBGArray:nil
                                                    fontColors:[NSArray arrayWithObjects:[UIColor whiteColor], [UIColor whiteColor], nil]
                                                      fontSize:14.0
                                                 selectedImage:[CommonDrawFunc retinaImageNamed:@"segmentSelect_BG.png"]
                                                     splitLine:nil
                                               bottomLineColor:nil];
    [ self.customSegmentCtl addTarget:self action:@selector(segmentAction:)];
    [imageView addSubview: self.customSegmentCtl];
    
    [scrollView addSubview:imageView];
    [self.view addSubview:scrollView];
    
    return imageView;
}

- (void)segmentAction:(CustomSegmentControl *)segmentControl
{
    NSLog(@"segmentControl index = %d",segmentControl.selectedSegmentIndex);
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
