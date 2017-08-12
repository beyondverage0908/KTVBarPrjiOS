//
//  KTVUtil.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/1.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUtil.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netdb.h>
//#include <sys/types.h>
//#include <sys/sysctl.h>
//#import <CommonCrypto/CommonDigest.h>
//#import <sys/utsname.h>

@implementation KTVUtil

// 判断网络连接状况处理
+ (BOOL)isNetworkAvailable {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (BOOL)isNullString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

+ (void)setObject:(id)obj forKey:(NSString *)key {
    if (!obj || !key || ![obj isKindOfClass:[NSObject class]] || ![key isKindOfClass:[NSString class]]) return;
    
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectForKey:(NSString *)key {
    if (!key || ![key isKindOfClass:[NSString class]]) return nil;
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
