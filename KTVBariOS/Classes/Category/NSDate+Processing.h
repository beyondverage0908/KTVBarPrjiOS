//
//  NSDate+Processing.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/22.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *
 * 此类用于时间的处理。具体使用看以下类方法的注释。。
 *
 * Created by Sheffi on 16/10/17。
 *
 */

@interface NSDate (Processing)

/**
 *  时间转换为时间戳方法
 *
 *  @param date 要转换的时间（NSDate的类型）
 *
 *  @return 时间戳字符串
 */
+(NSString *)timeStampWithDate:(NSDate *)date;
/**
 *  时间戳转换为时间字符串的方法
 *
 *  @param timeStamp 时间戳
 *  @param formatString 格式化的格式 例如：@"yyyy-MM-dd HH:mm"
 *
 *  @return 时间字符串
 */
+(NSString *)dateStringWithTimeStamp:(NSString *)timeStamp andFormatString:(NSString *)formatString;
/**
 *  格式化NSDate
 *
 *  @param date NSDate类型的时间
 *  @param formatString 格式化的格式 例如：@"yyyy-MM-dd HH:mm"
 *
 *  @return 格式化后的时间字符串
 */
+(NSString *)dateStringWithDate:(NSDate *)date andFormatString:(NSString *)formatString;
/**
 *  获取当前时间并进行格式化
 *
 *  @param formatString 格式化的格式 例如：@"yyyy-MM-dd HH:mm"
 *
 *  @return 返回格式化后的当前时间字符串
 */
+(NSString *)getCurrentDateWithFormatString:(NSString *)formatString;
/**
 *  时间字符串转换为NSDate类型
 *
 *  @param dateString 时间字符串
 *  @param formatString 格式化的格式，注意：这里的格式一定要和传入的时间字符串的格式一致，否则无法进行转换
 *
 *  @return 转换后的时间（NSDate类型）
 */
+(NSDate *)dateWithDateString:(NSString *)dateString andFormatString:(NSString *)formatString;

@end
