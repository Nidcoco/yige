//
//  AppDelegate+AppService.m
//  dingdingxuefu
//
//  Created by Eric on 2018/7/23.
//

#import "AppDelegate+AppService.h"
#import <UMShare/UMShare.h>
//#import "FGTabBarVC.h"

@implementation AppDelegate (AppService)

//处理从其他app跳回本应用事件
- (BOOL)customHandleOpenUrl:(NSURL *)url{
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
            [[FGPaymentManager sharedInstance] appHadBeenKilldedWithPaySatus:resultDic];
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
            [[FGPaymentManager sharedInstance] appHadBeenKilldedWithPaySatus:resultDic];
        }];
    }
    
    //########################
    //微信支付
    if ([url.scheme isEqualToString:kWechatAppKey] && [url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:[FGPaymentManager sharedInstance]];
    }
    
    //######################
    //如果是友盟分享的回调直接不做任何处理
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (result) {
        return result;
    }
    
    return YES;
}

#pragma mark ————— 初始化推送服务 —————
-(void)initJPushService: (NSDictionary *)launchOptions{
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:kJPushAppKey
                          channel:nil
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    if (!IsEmpty(kUserId)) {
        DLog(@"\n\n####%@#######\n\n\n",kUserId);
        [JPUSHService setAlias:kUserId completion:nil seq:0];
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    
    //iOS10 注册APNs
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        
        if (@available(iOS 10.0, *)) {
            [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError *error) {
                if (granted) {
#if !TARGET_IPHONE_SIMULATOR
                    [application registerForRemoteNotifications];
#endif
                }
            }];
        } else {
            // Fallback on earlier versions
        }
        
        return;
    }
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
#endif
    
}


//处理收到推送后的处理
- (void)handlePushData:(NSDictionary *)dict
{
    NSNumber *bageCount = [[NSUserDefaults standardUserDefaults] valueForKey:@"bageCount"];
    NSInteger count = bageCount.integerValue - 1;
    [[NSUserDefaults standardUserDefaults] setObject:@(count) forKey:@"bageCount"];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
    
    
//    if ([dict[@"type"] isEqualToString:@"1"]) {//活动
//        DDActivityDetailVC *vc = [DDActivityDetailVC new];
//        vc.activityId = dict[@"value"];
//        [self showCoustomVC:vc];
//    }
//    else if ([dict[@"type"] isEqualToString:@"2"]){//课程
//        DDCourseDetailVC *vc = [DDCourseDetailVC new];
//        vc.courseId = dict[@"value"];
//        [self showCoustomVC:vc];
//    }
//    else if ([dict[@"type"] isEqualToString:@"3"]){//公告
//        DDSystemListVC *vc = [DDSystemListVC new];
//        [self showCoustomVC:vc];
//    }else if ([dict[@"type"] isEqualToString:@"4"]){//课程开课
//        DDApplyDetailVC *vc = [DDApplyDetailVC new];
//        vc.courseId = dict[@"value"];
//        [self showCoustomVC:vc];
//    }else if ([dict[@"type"] isEqualToString:@"5"]){//一卡通门禁
//        
//    }
}

//- (void)showMessController
//{
//    if (UIApplicationStateActive == [UIApplication sharedApplication].applicationState) {
//        FGTabBarVC *tabbar = (FGTabBarVC *) kKeyWindow.rootViewController;
//        tabbar.selectedIndex = 2;
//    }else{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            FGTabBarVC *tabbar = (FGTabBarVC *) kKeyWindow.rootViewController;
//            tabbar.selectedIndex = 2;
//        });
//    }
// 
//}
//
//- (void)showCoustomVC:(UIViewController *)vc{
//    if (UIApplicationStateActive == [UIApplication sharedApplication].applicationState) {
//        FGTabBarVC *tabbar = (FGTabBarVC *) kKeyWindow.rootViewController;
//        FGBaseNavigationController *navi = tabbar.selectedViewController;
//        [navi pushViewController:vc animated:YES];
//    }else{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            FGTabBarVC *tabbar = (FGTabBarVC *) kKeyWindow.rootViewController;
//            FGBaseNavigationController *navi = tabbar.selectedViewController;
//            [navi pushViewController:vc animated:YES];
//        });
//    }
//}



@end
