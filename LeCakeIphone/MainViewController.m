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
#import "MainLeCakeTableCell.h"

#define kAdvHeight 150.0

@interface MainViewController ()

@end

@implementation MainViewController

- (id)init
{
    self = [super init];
	if (self)
	{
        self.title      = @"首页";
        self.showNav    = YES;
        self.resident   = YES;
        [self createTabBarItem:self.title iconImgName:@"tray_menu_home_normal.png" selIconImgName:@"tray_menu_home_highlighted.png"];
        
	}
	return self;
}


- (void)loadUIData
{
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setFrame:CGRectMake(100, 200, 80, 80)];
//    [btn setBackgroundColor:[UIColor redColor]];
//    [btn setTitle:@"Login" forState:UIControlStateNormal];
//    [btn setTintColor:[UIColor blackColor]];
//    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
//    [self loadAdvScrollViewUI];
    [self loadMianTableViewUI];
    
}

- (void)loadMianTableViewUI
{
    self.cakeListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-kSysStatusBarHeight-kLeCakeTabBarHeight-kSysNavBarHeight) style:UITableViewStylePlain];
    self.cakeListTable.delegate     = self;
    self.cakeListTable.dataSource   = self;
    [self.view addSubview:self.cakeListTable];
}

- (CycleScrollView *)loadAdvScrollViewUI
{
    NSMutableArray *viewsArray = [@[] mutableCopy];
    
    for (int i = 0 ; i < 3; i++)
    {
        UIImageView *advImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 150)];
        [advImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"adv%d.png",i+1]]];
        [viewsArray addObject:advImgView];
        
    }
    
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 150) animationDuration:3];
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return [viewsArray count];
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%d个",pageIndex);
    };
    return self.mainScorllView;
   // [self.view addSubview:self.mainScorllView];

}

- (void)btnAction:(id)sender
{
    LoginViewController * ndVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:ndVC animated:YES];
    [self setHiddenTabBarView:YES];
    
  /*
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/data/ipad/news/index.json" withReqTag:1];
    
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/data/lottery/version.json" withReqTag:2];
    
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/data/ipad/news/jrtt/page_1.json" withReqTag:3];
    
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/news/news/gaoduan/zindex.json" withReqTag:4];
    
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/data/topicnews/today.json" withReqTag:5];
    
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/data/gold/jygz.json" withReqTag:6];
    
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/data/news/news/sjzx/txsxw/toutiao.json" withReqTag:7];
   */
    
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
#pragma mark - UITableView 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select row = %d",indexPath.row);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        UIView * sycleView = [cell viewWithTag:100];
        if (!sycleView) {
            CycleScrollView * advScrollView = [self loadAdvScrollViewUI];
            advScrollView.tag = 100;
            [cell.contentView addSubview:advScrollView];
        }
        
        return  cell;

    }else
    {
        static NSString *CellIdentifier1 = @"Cell1";
        MainLeCakeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[MainLeCakeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        [cell.leftTitle setText:@"只是口味"];
        [cell.rightTitle setText:@"金牌品质金牌味道"];
        [cell.cakeImgView setImage:[UIImage imageNamed:@"adv1.png"]];
        [cell.cakeTipImgView setImage:[UIImage imageNamed:@"leCakeCellTip.png"]];
        [cell.instructionName setText:@"提拉米苏蛋糕"];
        [cell.instructionDetails setText:@"le chess Cake"];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
    }
    
	return 150;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 150;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kAdvHeight)];
//    CycleScrollView * advScrollView = [self loadAdvScrollViewUI];
//    [view addSubview:advScrollView];
//    return view;
//}

@end
