//
//  CommonGetPlistFunc.h
//  LeCakeIphone
//
//  Created by David on 14-10-22.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonGetPlistFunc : NSObject
// 取tabBar 下面多少个VC
+ (NSArray *)getTabBarViewControllers;

// 取数据保存路径
+ (NSString *) getFilePath:(NSString *)file;
@end
