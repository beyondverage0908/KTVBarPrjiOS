//
//  AppDelegate.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/6/28.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "AppDelegate.h"
#import "KTVShareSDKManager.h"
#import "KTVGaodeManager.h"
#import "KTVRongCloudManager.h"
#import <Pingpp/Pingpp.h>
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>
#import "KTVMainService.h"
#import <UserNotifications/UserNotifications.h>

#define PGY_APPKEY @"1f835f0df5780f24a8a1846fe72b91e3"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 初始ShareSDK
    [KTVShareSDKManager shareSDKInitial];
    // 启动高德app就定位
    [[KTVGaodeManager defaultGaode] startSerialLocation];
    
    // 开启蒲公英
    [self startPgy];
    // 地理逆解析demo
    KTVAddress *address = [[KTVAddress alloc] init];
    address.latitude = 31.25585856119792;
    address.longitude = 121.3237915039062;
    [[KTVGaodeManager defaultGaode] startReGeocodeWithLocation:address completionBlock:^(AMapReGeocode *reGencode) {
        CLog(@"--->>> %@", reGencode);
    }];
    
    [self registerRemoteNotificationType:application];
    [self getRongCloudToken];
    
    [KtvNotiCenter addObserver:self selector:@selector(updateUserLocation:) name:KNotUserLocationUpdate object:nil];
    return YES;
}

- (void)startPgy {
    //  关闭用户手势反馈，默认为开启。
      [[PgyManager sharedPgyManager] setEnableFeedback:NO];
    
    //  设置用户反馈激活模式为三指拖动，默认为摇一摇。
      [[PgyManager sharedPgyManager] setFeedbackActiveType:kPGYFeedbackActiveTypeThreeFingersPan];
    
    //  设置用户反馈界面的颜色，会影响到Title的背景颜色和录音按钮的边框颜色，默认为0x37C5A1(绿色)。
      [[PgyManager sharedPgyManager] setThemeColor:[UIColor blackColor]];
    
    //  设置摇一摇灵敏度，数字越小，灵敏度越高，默认为2.3。
      [[PgyManager sharedPgyManager] setShakingThreshold:3.0];
    
    //  启动SDK
    //  设置三指拖动激活摇一摇需在此调用之前
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:PGY_APPKEY];
    [[PgyManager sharedPgyManager] startManagerWithAppId:PGY_APPKEY];

    //  是否显示蒲公英SDK的Debug Log，如果遇到SDK无法正常工作的情况可以开启此标志以确认原因，默认为关闭。
    [[PgyManager sharedPgyManager] setEnableDebugLog:YES];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [application setApplicationIconBadgeNumber:0];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 推送

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (completionHandler) {
        completionHandler(UIBackgroundFetchResultNewData);
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[[[deviceToken description]
                         stringByReplacingOccurrencesOfString:@"<" withString:@""]
                        stringByReplacingOccurrencesOfString:@">" withString:@""]
                       stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}

/// 推送通知类型注册
- (void)registerRemoteNotificationType:(UIApplication *)application {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    [application registerForRemoteNotifications];
                }
            });
        }];
    } else {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}


#pragma mark - 用于APP之间调用的回调

// iOS8
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
}
// >= iOS9
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
}


#pragma mark - 网络

// 获取融云的token
- (void)getRongCloudToken {
    NSString *username = [KTVCommon userInfo].phone;
    NSString *rcToken = [KTVUtil objectForKey:@"rongCloudToken"];
    if (username && !rcToken) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:username forKey:@"userId"];
        
        NSString *nickName = [KTVCommon userInfo].nickName;
        [params setObject:nickName ? nickName : @"" forKey:@"name"];
        
        KTVPicture *pic = [KTVCommon userInfo].pictureList.firstObject;
        [params setObject:pic.pictureUrl ? pic.pictureUrl : @"" forKey:@"portraitUri"];
        
        [KTVMainService getRongCloudToken:params result:^(NSDictionary *result) {
            if ([result[@"code"] isEqualToString:ktvCode]) {
                [KTVCommon setUserInfoKey:@"rongCloudToken" infoValue:result[@"data"][@"token"]];
                [[KTVRongCloudManager shareManager] rongInit];
            }
        }];
    }
}

// 更新用户的地理位置
- (void)updateUserLocation:(NSNotification *)noti {
    KTVAddress *location = noti.object;
    if ([KTVCommon userInfo].phone && location) {
        NSDictionary *params = @{@"username" : [KTVCommon userInfo].phone,
                                 @"address" : @{@"latitude" : @(location.latitude).stringValue, @"longitude" : @(location.longitude).stringValue}};
        [KTVMainService postRecentUserAddress:params result:^(NSDictionary *result) {}];
    }
}

@end
