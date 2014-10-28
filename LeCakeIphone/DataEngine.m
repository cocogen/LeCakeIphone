//
//  DataEngine.m
//  LeCakeIphone
//
//  Created by David on 14-10-27.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import "DataEngine.h"
#import "AFNetworking.h"


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
@end
