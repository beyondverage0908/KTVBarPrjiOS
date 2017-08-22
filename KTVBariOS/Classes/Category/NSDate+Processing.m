//
//  NSDate+Processing.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/22.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "NSDate+Processing.h"

@implementation NSDate (Processing)

+(NSString *)timeStampWithDate:(NSDate *)date{
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    return timeStamp;
}

+(NSString *)dateStringWithTimeStamp:(NSString *)timeStamp andFormatString:(NSString *)formatString{
    NSString *dateString;
    NSDate *tmpDate = [NSDate dateWithTimeIntervalSince1970:[timeStamp floatValue]];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:formatString];
    dateString = [format stringFromDate:tmpDate];
    return dateString;
}

+(NSString *)dateStringWithDate:(NSDate *)date andFormatString:(NSString *)formatString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"dateString:%@",dateString);
    return dateString;
}

+(NSString *)getCurrentDateWithFormatString:(NSString *)formatString{
    NSDate *currentDate = [NSDate date];
    NSString *currentDateString = [self dateStringWithDate:currentDate andFormatString:formatString];
    return currentDateString;
}

+(NSDate *)dateWithDateString:(NSString *)dateString andFormatString:(NSString *)formatString{
    NSDate *tmpDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    tmpDate = [dateFormatter dateFromString:dateString];
    return tmpDate;
}

@end
