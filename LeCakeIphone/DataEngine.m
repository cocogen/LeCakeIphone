//
//  DataEngine.m
//  LeCakeIphone
//
//  Created by David on 14-10-27.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import "DataEngine.h"
#import "AFNetworking.h"


@interface DataEngine()
- (void)initUserInfoData;
- (void)loadUserInfoData;
- (void)saveUserInfoData;
@end
@implementation DataEngine

+(DataEngine *)sharedDataEngine
{
    static DataEngine *sharedDataEngineInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedDataEngineInstance = [[self alloc] init];
    });
    
    return sharedDataEngineInstance;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self initUserInfoData];
        [self loadUserInfoData];
    }
    return self;
}

// http get请求
- (void)reqAsyncHttpGet:(id)target urlStr:(NSString *)urlStr userInfo:(NSDictionary *)userInfo withReqTag:(int)tag
{
    NSDictionary * tmpUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",tag],@"tag", nil];
    
     __weak __typeof(CMViewController)*weakSelf = target;
    
    AFHTTPRequestOperationManager * requestOpeManager = [AFHTTPRequestOperationManager manager];
    [requestOpeManager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = tmpUserInfo;
        __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf reflashTargetUI:strongSelf responseData:responseObject withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         operation.userInfo = tmpUserInfo;
         __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf httpResponseError:strongSelf errorInfo:error withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];
        
    }];
}

// http post请求
- (void)reqAsyncHttpPost:(id)target urlStr:(NSString *)urlStr userInfo:(NSDictionary *)userInfo withReqTag:(int)tag
{
    NSDictionary * tmpUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",tag],@"tag", nil];
    
    __weak __typeof(CMViewController)*weakSelf = target;
    
    AFHTTPRequestOperationManager * requestOpeManager = [AFHTTPRequestOperationManager manager];
    [requestOpeManager POST:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = tmpUserInfo;
        __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf reflashTargetUI:strongSelf responseData:responseObject withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = tmpUserInfo;
        __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf httpResponseError:strongSelf errorInfo:error withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];

    }];
}
// http json请求
- (void)reqJsonHttp:(id)target urlStr:(NSString *)jsonURL withReqTag:(int)tag
{
     __weak __typeof(CMViewController)*weakSelf = target;
    NSDictionary * tmpUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",tag],@"tag", nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:jsonURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = tmpUserInfo;
        __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf parseJsonDataInUI:strongSelf jsonData:responseObject withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = tmpUserInfo;
        __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf httpResponseError:strongSelf errorInfo:error withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];
    }];
}
#pragma --
#pragma 初始化数据
- (void)initUserInfoData
{
    NSString *filePath = [CommonGetPlistFunc getFilePath:@"user.plist"];
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    
    if (!userDic)
    {
        userDic = [[NSMutableDictionary alloc] init];
        [userDic setValue:@"15001792132" forKey:kPhoneNumberKey];
        [userDic setValue:@"cocogen" forKey:kUserNameKey];
        [userDic setValue:@"123456" forKey:kUserPwdKey];
        
//        [userDic writeToFile:filePath atomically:YES];
    }
    
}
- (void)loadUserInfoData
{
    NSString *filepath = [CommonGetPlistFunc getFilePath:@"user.plist"];
    
    if (filepath != nil)
    {
        NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
        
        if (userDic != nil)
        {
//            // 登录界面设置
//            bSaveUserName		= ![userDic valueForKey:kSaveUserNameKey] || ([userDic valueForKey:kSaveUserNameKey] && [[userDic valueForKey:kSaveUserNameKey] intValue] != 0) ? YES : NO;
//            bAutoLogin			= ![userDic valueForKey:kAutoLoginKey] || ([userDic valueForKey:kAutoLoginKey] && [[userDic valueForKey:kAutoLoginKey] intValue] != 0) ? YES : NO;
//            char *mobile        = [userDic valueForKey:kPhoneNumberKey] ? (char *)[[userDic valueForKey:kPhoneNumberKey] UTF8String] : "";
//            strcpy(reg_mobilephone, mobile);
        }
    }
}
- (void)saveUserInfoData
{
    NSString *filepath = [CommonGetPlistFunc getFilePath:@"user.plist"];
    //if (filepath != nil) [reqMainPageSHAndSZStock writeToFile:filepath atomically:YES];
}

@end
