//
//  CMViewController.m
//  LeCakeIphone
//
//  Created by David on 14-10-21.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import "CMViewController.h"
#import "CommonDrawFunc.h"
#import "NavigationFunc.h"
#import "CommonDefine.h"

@interface CMViewController ()

@end

@implementation CMViewController

@synthesize cMTabBarItem    = _cMTabBarItem;
@synthesize tabBarIndex     = _tabBarIndex;
@synthesize showNav         = _showNav;
@synthesize resident        = _resident;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initData];
    }
    
    return self;
}

//- (void)dealloc
//{
//    NSLog(@"dealloc<<<<<<<<<<<<<<%@<<<<%@<<<<", self, self.objectTag);
//    [[CMNetLayerNotificationCenter defaultCenter] removeObserver:self name:self.objectTag object:nil];
//    [[CMNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@request", self.objectTag] object:nil];
//    [[CMNotificationCenter defaultCenter] removeObserver:self name:kThemeChangeNotification object:nil];
//    
//    self.objectTag      = nil;
//    self.cMTabBarItem   = nil;
//    
//    [super dealloc];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if ([[[UIDevice currentDevice] systemVersion] doubleValue] < 5.0) self.navigationController.delegate = self;
    if ((floor(NSFoundationVersionNumber))>NSFoundationVersionNumber_iOS_6_1 && [[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) [self setNeedsStatusBarAppearanceUpdate];
    
    [NavigationFunc setNavigationBarBackgrounImage:self image:[CommonDrawFunc retinaImageNamed:(IOS_VERSION_7_OR_ABOVE ? @"navigationBarBGIOS7.png" : @"navigationBarBG.png")]];

    
    [self loadUIData];
}

- (void)viewDidUnload           // iOS 6 later, the viewDidUnload method is not used
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if ([self isViewLoaded] && self.view.window == nil)
    {
        [self receiveLowMemoryWarning];
        self.view = nil;
        
    }
}

#pragma mark - IOS6 Rotation
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Private's methods
- (void)initData
{
    self.objectTag  = [self uuidString];
    _showNav        = YES;
    _resident       = NO;
    _tabBarIndex    = -1;
    
//    NSLog(@"<<<<<<<<<<<<<<%@<<<<%@<<<<", self, self.objectTag);
//    
//    [[CMNetLayerNotificationCenter defaultCenter] addObserver:self selector:@selector(vcMsgCenterProcessInMainThread:) name:self.objectTag object:nil];
//    [[CMNotificationCenter defaultCenter] addObserver:self selector:@selector(vcMsgCenterRequestProcessThread:) name:[NSString stringWithFormat:@"%@request", self.objectTag] object:nil];
//    [[CMNotificationCenter defaultCenter] addObserver:self selector:@selector(vcMsgThemeChange:) name:kThemeChangeNotification object:nil];
    
    [self initExtendedData];
}

#pragma mark - Public's methods
- (void)initExtendedData
{
    
}

- (void)loadUIData
{
    
}

- (void)receiveLowMemoryWarning
{
    
}

//消息到达
- (void)vcMsgCenterProcessInMainThread:(NSNotification *)notification
{
    [self performSelectorInBackground:@selector(tmpResponseProcessThreadAction:) withObject:notification];
}
- (void)vcMsgCenterRequestProcessThread:(NSNotification *)notification
{
    [self performSelectorInBackground:@selector(tmpRequestProcessThreadAction:) withObject:notification];
}

- (void)tmpResponseProcessThreadAction:(NSNotification *)notification
{
    @autoreleasepool {
        [self performSelector:@selector(vcMsgCenterProcess:) withObject:notification];
    }
}

- (void)tmpRequestProcessThreadAction:(NSNotification *)notification
{
    @autoreleasepool {
        [self performSelector:@selector(vcMsgCenterRequestProcess:) withObject:notification];
    }
}

- (void)vcMsgThemeChange:(NSNotification *)notification {}
- (void)vcMsgCenterProcess:(NSNotification *)notification {}
- (void)vcMsgCenterRequestProcess:(NSNotification *)notification {}

- (void)setHiddenTabBarView:(BOOL)isHidden
{
    UIView *tbV = [_cMTabBarItem superview];
    if (tbV)
    {
        [tbV setHidden:isHidden];
    }
}

#pragma mark - UINavigationControllerDelegate's methods
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    static UIViewController *lastController = nil;
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] < 5.0)
    {
        if (lastController != nil)
        {
            if ([lastController respondsToSelector:@selector(viewWillDisappear:)])
                [lastController viewWillDisappear:animated];
        }
        
        lastController = viewController;
        [viewController viewWillAppear:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    static UIViewController *lastController = nil;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] < 5.0 )
    {
        if (lastController != nil)
        {
            if ([lastController respondsToSelector:@selector(viewDidDisappear:)])
                [lastController viewDidDisappear:animated];
        }
        
        lastController = viewController;
        [viewController viewDidAppear:animated];
    }
}

// push到navigationController指定类名对应的controller
- (UIViewController*)popToTargetControllerByName:(NSString *)targetName
{
    return [self popToTargetControllerByName:targetName animated:YES];
}

- (UIViewController*)popToTargetControllerByName:(NSString *)targetName animated:(BOOL)animated;
{
    for (UIViewController *ctrl in self.navigationController.viewControllers)
    {
        if([NSStringFromClass([ctrl class]) isEqualToString:targetName] || [ctrl isKindOfClass:NSClassFromString(targetName)])
        {
            [self.navigationController popToViewController:ctrl animated:animated];
            return ctrl;
        }
    }
    return nil;
}

- (void)createTabBarItem:(NSString *)title iconImgName:(NSString *)iconImgName selIconImgName:(NSString *)selIconImgName
{
    self.cMTabBarItem   = [[TabBarItem alloc] initWithFrame:CGRectZero];
    self.cMTabBarItem.topOffset = 7;
    UIImage *iconImg    = iconImgName ? [CommonDrawFunc retinaImageNamed:iconImgName] : nil;
    UIImage *selIconImg = selIconImgName ? [CommonDrawFunc retinaImageNamed:selIconImgName] : nil;
    [self.cMTabBarItem setNormalIconImage:iconImg];
    [self.cMTabBarItem setSelectedIconImage:selIconImg];
    [self.cMTabBarItem setTitle:title];
    [self.cMTabBarItem setTitleFont:[UIFont systemFontOfSize:12]];
    [self.cMTabBarItem setNormalTitleColor:[UIColor lightGrayColor]];
    [self.cMTabBarItem setSelectedTitleColor:[UIColor whiteColor]];
}

- (void)reflashUI:(UIViewController *)vc
{
    if (vc == self)
    {
        NSLog(@"vc is Eaqual self");
    }else
    {
         NSLog(@"vc is not Eaqual self");
    }
}

- (void)parseJsonData:(UIViewController *)vc withTag:(int)tag
{
    NSLog(@"vc = %@,tag =%d",vc,tag);
}
@end
