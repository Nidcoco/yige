//
//  AppDelegate+AppService.h
//  dingdingxuefu
//
//  Created by Eric on 2018/7/23.
//

#import "AppDelegate.h"
#import "FGPaymentManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import <JPUSHService.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate (AppService)<JPUSHRegisterDelegate>

//处理OpenURL 回调
- (BOOL)customHandleOpenUrl:(NSURL *)url;

-(void)initJPushService: (NSDictionary *)launchOptio;

//处理收到推送后的处理
- (void)handlePushData:(NSDictionary *)userInfo;
@end
