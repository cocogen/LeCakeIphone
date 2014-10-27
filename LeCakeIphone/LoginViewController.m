//
//  LoginViewController.m
//  LeCakeIphone
//
//  Created by David on 14-10-24.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import "LoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)loadUIData
{    
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
    self.wxLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 微信
    float offxspace = 20; //btn离边界
    float btnWidth = (rect.size.width - 4 * offxspace)/3; //btn的宽度
    [self.wxLoginBtn setFrame:CGRectMake(offxspace, rect.size.height - kSysNavBarHeight - 80, btnWidth, 40)];
    [self.wxLoginBtn setBackgroundImage:[CommonDrawFunc retinaImageNamed:@"icon48_wx_button.png"] forState:UIControlStateNormal];
    [self.wxLoginBtn addTarget:self action:@selector(wxLoginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.wxLoginBtn];
    
    // qq
    self.qqLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.qqLoginBtn setFrame:CGRectMake(self.wxLoginBtn.frame.origin.x + btnWidth + offxspace, rect.size.height - kSysNavBarHeight - 80, btnWidth, 40)];
    [self.qqLoginBtn setBackgroundImage:[CommonDrawFunc retinaImageNamed:@"icon48_wx_button.png"] forState:UIControlStateNormal];
    [self.qqLoginBtn addTarget:self action:@selector(qqLoginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.qqLoginBtn];

    // sina
    self.sinaLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.sinaLoginBtn setFrame:CGRectMake(self.qqLoginBtn.frame.origin.x + btnWidth + offxspace, rect.size.height - kSysNavBarHeight - 80, btnWidth, 40)];
    [self.sinaLoginBtn setBackgroundImage:[CommonDrawFunc retinaImageNamed:@"icon48_wx_button.png"] forState:UIControlStateNormal];
    [self.sinaLoginBtn addTarget:self action:@selector(sinaLoginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sinaLoginBtn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wxLoginBtnAction:(id)sender
{
    // 判断是否安装微信客户端
    if (![WXApi isWXAppInstalled]) {
        return;
    }
    
    if (![ShareSDK getCredentialWithType:ShareTypeWeixiSession]) {
        
        //设置授权选项
        id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                             allowCallback:YES
                                                             authViewStyle:SSAuthViewStyleFullScreenPopup
                                                              viewDelegate:nil
                                                   authManagerViewDelegate:nil];
        
        //在授权页面中添加关注官方微博
        [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                        SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                        [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                        SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                        nil]];
        
        [ShareSDK getUserInfoWithType:ShareTypeWeixiSession
                          authOptions:authOptions
                               result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                   
                                   if (result)
                                   {
                                       id<ISSPlatformCredential> creadtial = [userInfo credential];
                                       
                                       NSLog(@"openId = %@", creadtial.uid);
                                       
                                    }
                                   else
                                   {
                                       NSLog(@"error code = %d,error description = %@",error.errorCode,error.errorDescription);
//                                       UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TEXT_TIPS", @"提示")
//                                                                                           message:error.errorDescription
//                                                                                          delegate:nil
//                                                                                 cancelButtonTitle:NSLocalizedString(@"TEXT_KNOW", @"知道了")
//                                                                                 otherButtonTitles: nil];
//                                       [alertView show];
//                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }
                                   
                               }];
        

    }
}

- (void)qqLoginBtnAction:(id)sender
{
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/data/ipad/news/index.json" withReqTag:1];
    
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/data/lottery/version.json" withReqTag:2];
    
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/data/ipad/news/jrtt/page_1.json" withReqTag:3];
    
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/news/news/gaoduan/zindex.json" withReqTag:4];
    
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/data/topicnews/today.json" withReqTag:5];
    
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/data/gold/jygz.json" withReqTag:6];
    
    [[DataEngine sharedDataEngine] reqJsonHttp:self urlStr:@"http://mnews.gw.com.cn/wap/data/ipad/news/qtsc/page_1.json" withReqTag:7];
    
    /*
    // 微信发好友
    id<ISSContent> content = [ShareSDK content:@"帅哥，最近怎么样？"
                                defaultContent:nil
                                         image:[ShareSDK jpegImageWithImage:[UIImage imageNamed:@"res2.jpg"] quality:1]
                                         title:@"我在吃诺心的蛋糕啊"
                                           url:@"http://view.news.qq.com/zt2012/mdl/index.htm"
                                   description:nil
                                     mediaType:SSPublishContentMediaTypeNews];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    [ShareSDK shareContent:content
                      type:ShareTypeWeixiSession
               authOptions:authOptions
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(@"success");
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            if ([error errorCode] == -22003)
                            {
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TEXT_TIPS", @"提示")
                                                                                    message:[error errorDescription]
                                                                                   delegate:nil
                                                                          cancelButtonTitle:NSLocalizedString(@"TEXT_KNOW", @"知道了")
                                                                          otherButtonTitles:nil];
                                [alertView show];
                            }
                        }
                    }];
     */

}

- (void)sinaLoginBtnAction:(id)sender
{
//    // 微信收藏
//    id<ISSContent> content = [ShareSDK content:@"可以看看下面这个东东"
//                                defaultContent:nil
//                                         image:[ShareSDK jpegImageWithImage:[UIImage imageNamed:@"res2.jpg"] quality:1]
//                                         title:@"没事别找事"
//                                           url:@"http://view.news.qq.com/zt2012/mdl/index.htm"
//                                   description:nil
//                                     mediaType:SSPublishContentMediaTypeNews];
//    
//    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//                                                         allowCallback:YES
//                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
//                                                          viewDelegate:nil
//                                               authManagerViewDelegate:nil];
//    
//    //在授权页面中添加关注官方微博
//    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
//                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
//                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
//                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
//                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
//                                    nil]];
//    
//    [ShareSDK shareContent:content
//                      type:ShareTypeWeixiFav
//               authOptions:authOptions
//             statusBarTips:YES
//                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                        
//                        if (state == SSPublishContentStateSuccess)
//                        {
//                            NSLog(@"success");
//                        }
//                        else if (state == SSPublishContentStateFail)
//                        {
//                            if ([error errorCode] == -22003)
//                            {
//                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TEXT_TIPS", @"提示")
//                                                                                    message:[error errorDescription]
//                                                                                   delegate:nil
//                                                                          cancelButtonTitle:NSLocalizedString(@"TEXT_KNOW", @"知道了")
//                                                                          otherButtonTitles:nil];
//                                [alertView show];
//                            }
//                        }
//                    }];
    
    id<ISSContent> content = [ShareSDK content:@"诺心呗好吃啊"
                                defaultContent:nil
                                         image:[ShareSDK jpegImageWithImage:[UIImage imageNamed:@"res2.jpg"] quality:1]
                                         title:@"想吃吗哈哈"
                                           url:@"http://view.news.qq.com/zt2012/mdl/index.htm"
                                   description:nil
                                     mediaType:SSPublishContentMediaTypeNews];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    [ShareSDK shareContent:content
                      type:ShareTypeWeixiTimeline
               authOptions:authOptions
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(@"success");
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            if ([error errorCode] == -22003)
                            {
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TEXT_TIPS", @"提示")
                                                                                    message:[error errorDescription]
                                                                                   delegate:nil
                                                                          cancelButtonTitle:NSLocalizedString(@"TEXT_KNOW", @"知道了")
                                                                          otherButtonTitles:nil];
                                [alertView show];
                            }
                        }
                    }];


}

@end
