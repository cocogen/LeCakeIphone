//
//  DataEngine.h
//  LeCakeIphone
//
//  Created by David on 14-10-27.
//  Copyright (c) 2014年 NX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMViewController.h"
#import "CommonGetPlistFunc.h"

@interface DataEngine : NSObject

/*!@brief DataEngine的类函数，生成单态实例。
* @return DataEngine。
*/
+(DataEngine *)sharedDataEngine;

/*!@brief DataEngine的成员函数，发起客户端的http get请求。
 * @param target    对应的哪个ViewController,http返回后的页面处理也是在该vc中处理
 * @param urlStr    请求对应的http的URL
 * @param userInfo  请求对应的参数，以K-V形式传
 * @param tag       页面如果同时发起多个请求，必须标记tag,以区别返回的数据是哪个请求发的
 * @return none。
 */
- (void)reqAsyncHttpGet:(id)target urlStr:(NSString *)urlStr userInfo:(NSDictionary *)userInfo withReqTag:(int)tag;

/*!@brief DataEngine的成员函数，发起客户端的http post请求。
 * @param target    对应的哪个ViewController,http返回后的页面处理也是在该vc中处理
 * @param urlStr    请求对应的http的URL
 * @param userInfo  请求对应的参数，以K-V形式传
 * @param tag       页面如果同时发起多个请求，必须标记tag,以区别返回的数据是哪个请求发的
 * @return none。
 */
- (void)reqAsyncHttpPost:(id)target urlStr:(NSString *)urlStr userInfo:(NSDictionary *)userInfo withReqTag:(int)tag;

/*!@brief DataEngine的成员函数，发起客户端的http post请求。
 * @param target    对应的哪个ViewController,http返回后的页面处理也是在该vc中处理
 * @param jsonURL   请求对应的http的URL
 * @param tag       页面如果同时发起多个请求，必须标记tag,以区别返回的数据是哪个请求发的
 * @return none。
 */
- (void)reqJsonHttp:(id)target urlStr:(NSString *)jsonURL withReqTag:(int)tag;

@end
