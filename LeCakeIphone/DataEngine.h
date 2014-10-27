//
//  DataEngine.h
//  LeCakeIphone
//
//  Created by David on 14-10-27.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMViewController.h"

@interface DataEngine : NSObject
// 单态实例
+(DataEngine *)sharedDataEngine;

// http get请求
- (void)reqAsyncHttp:(id)target urlStr:(NSString *)urlStr userInfo:(NSDictionary *)userInfo;

// http json请求
- (void)reqJsonHttp:(id)target urlStr:(NSString *)jsonURL withReqTag:(int)tag;
@end
