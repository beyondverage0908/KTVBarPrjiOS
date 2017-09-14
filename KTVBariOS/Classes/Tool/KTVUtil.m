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

+ (void)tellphone:(NSString *)phone {
    if ([KTVUtil isNullString:phone]) return;
    
    NSURL *telUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phone]];
    if ([[UIApplication sharedApplication] canOpenURL:telUrl]) {
        [[UIApplication sharedApplication] openURL:telUrl];
    }
}

+ (NSArray *)getFiltertimeByDay:(NSInteger)days {
    
    NSMutableArray *filtertimeList = [NSMutableArray arrayWithCapacity:days];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [NSDate date];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"MM-dd"];
    for (int i = 0; i < days; i ++) {
        NSDate *d = [today dateByAddingTimeInterval:i * secondsPerDay];
        NSString *week = [self calculateWeek:d];
        NSString *dateString = [myDateFormatter stringFromDate:d];
        NSString *filerString = [NSString stringWithFormat:@"%@;%@", week, dateString];
        
        [filtertimeList addObject:filerString];
    }
    
    return [filtertimeList copy];
}

+ (NSString *)calculateWeek:(NSDate *)date {

    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString1 = [myDateFormatter stringFromDate:date];
    NSString *dateString2 = [myDateFormatter stringFromDate:[NSDate date]];
    
    if ([dateString1 isEqualToString:dateString2]) {
        return @"今天";
    }
    
    //计算week数
    NSCalendar * myCalendar = [NSCalendar currentCalendar];
    myCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSInteger week = [[myCalendar components:NSCalendarUnitWeekday fromDate:date] weekday];
    switch (week) {
        case 1:
        {
            return @"周日";
        }
        case 2:
        {
            return @"周一";
        }
        case 3:
        {
            return @"周二";
        }
        case 4:
        {
            return @"周三";
        }
        case 5:
        {
            return @"周四";
        }
        case 6:
        {
            return @"周五";
        }
        case 7:
        {
            return @"周六";
        }
    }
    return @"";
}

@end
