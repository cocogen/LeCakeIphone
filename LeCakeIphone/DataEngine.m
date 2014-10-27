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

- (void)reqAsyncHttp:(id)target urlStr:(NSString *)urlStr userInfo:(NSDictionary *)userInfo
{
     __weak __typeof(CMViewController)*weakSelf = target;
    
    AFHTTPRequestOperationManager * requestOpeManager = [AFHTTPRequestOperationManager manager];
    [requestOpeManager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"uuisString = %@,responseObject = %@,current thread = %@",operation.uuidString,responseObject,[NSThread currentThread]);
        
        __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf reflashUI:strongSelf];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)reqJsonHttp:(id)target urlStr:(NSString *)jsonURL withReqTag:(int)tag
{
     __weak __typeof(CMViewController)*weakSelf = target;
    NSDictionary * tmpUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",tag],@"tag", nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [manager GET:jsonURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        NSLog(@"responseSerializer =%lu",(unsigned long)operation.responseStringEncoding);
        //operation.responseSerializer setStringEncoding:@"UTF-8"
        operation.userInfo = tmpUserInfo;
        NSLog(@"uuisString百度 =test %@,responseObject = %@,current thread = %@",operation.uuidString,responseObject,[NSThread currentThread]);
        
        __strong __typeof(CMViewController)*strongSelf = weakSelf;
        [strongSelf parseJsonData:strongSelf withTag:[(NSNumber *)[operation.userInfo objectForKey:@"tag"] intValue]];
//        [strongSelf reflashUI:strongSelf];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
