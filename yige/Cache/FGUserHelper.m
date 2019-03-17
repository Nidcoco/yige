//
//  FGUserHelper.m
//  dingdingxuefu
//
//  Created by Eric on 2018/7/3.
//  Copyright © 2018年 DD. All rights reserved.
//

#import "FGUserHelper.h"
#import "FGLoginVC.h"

@implementation FGUserHelper

+ (void)requestUserModelWithResult:(void(^)(BOOL success,NSString *error))result;
{
    if (IsEmpty([FGCacheManager sharedInstance].token)) {
        if (result) {
            result(NO,@"未登录");
        }
        return;
    }

    //根据token获取到用户信息
    [FGHttpManager getWithPath:@"api/user" parameters:nil success:^(id responseObject) {
        if (IsEmpty(responseObject)) {
            if (result) {
                result(NO,@"未获取到用户数据");
            }
        }else{
            FGUserModel *model = [FGUserModel modelWithJSON:responseObject];
            [FGCacheManager sharedInstance].userModel = model;
            if (result) {
                result(YES,nil);
            }
        }
    } failure:^(NSString *error) {
        if (result) {
            result(NO,error);
        }
    }];
    
}

+ (void)reloadTokenWithSuccess:(void(^)(void))success
{
    if (IsEmpty([FGCacheManager sharedInstance].token)) {
        return;
    }
    
    NSString *url = [BaseApi stringByAppendingPathComponent:@"/api/authorizations/current"];
    [[FGHttpManager manager] PUT:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        FGResponseModel *obj = [FGResponseModel modelWithJSON:responseObject];
        
        if (obj.code.integerValue == 0) {
            NSString *token = objectForKey(responseObject, @"access_token");
            if (!IsEmpty(token)) {
                [FGCacheManager sharedInstance].token = token;
                success();
            }
        }else if ([obj.msg isEqualToString:@"The token has been blacklisted"] || [obj.msg isEqualToString:@"Token could not be parsed from the request."]){
            [FGUserHelper logout];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)logout{
    
    [FGHttpManager deleteWithPath:@"api/authorizations/current" parameters:nil success:^(id responseObject) {
        [FGCacheManager sharedInstance].token = nil;
        [FGCacheManager sharedInstance].userModel = nil;
    } failure:^(NSString *error) {
        [FGCacheManager sharedInstance].token = nil;
        [FGCacheManager sharedInstance].userModel = nil;
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSucceedNotification object:nil userInfo:nil];
}

+ (BOOL)isToken{
    if ([FGCacheManager sharedInstance].token) {
        return YES;
    }
    return NO;
}

+ (BOOL)isLogin:(UIViewController *)viewController
{
    if (![self isToken]) { //未登录 跳转到登录界面
        FGLoginVC *vc = [FGLoginVC new];
        [viewController.navigationController  pushViewController:vc animated:YES];
        return NO;
    }
    return YES;
}




@end
