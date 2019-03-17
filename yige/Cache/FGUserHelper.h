//
//  FGUserHelper.h
//  dingdingxuefu
//
//  Created by Eric on 2018/7/3.
//  Copyright © 2018年 DD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGUserHelper : NSObject

/**
 获取用户信息
 */
+ (void)requestUserModelWithResult:(void(^)(BOOL success,NSString *error))result;

/**
  刷新访问token
 */
+ (void)reloadTokenWithSuccess:(void(^)(void))success;

/**
 退出登录 清空token
 */
+ (void)logout;


/**
 是否为空Token 判断是否登录
 */
+ (BOOL)isToken;

/**
 判断是否登录

 @return NO 未登录(跳转到登录界面) YES 已登录
 */
+ (BOOL)isLogin:(UIViewController *)viewController;


@end
