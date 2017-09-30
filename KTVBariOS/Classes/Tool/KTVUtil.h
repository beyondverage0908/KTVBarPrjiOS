//
//  KTVUtil.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/1.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTVUtil : NSObject
/// 判断是否有网络
+ (BOOL)isNetworkAvailable;
/// 判断字符串是否为空
+ (BOOL)isNullString:(NSString *)string;
/// 保存数据到UserDefault中
+ (void)setObject:(id)obj forKey:(NSString *)key;
/// UserDefault中获取数据
+ (id)objectForKey:(NSString *)key;
/// 打电话
+ (void)tellphone:(NSString *)phone;
/*
 * 获取从当前时间开始，往后的月日的数组
 * @param days: 获取的天数长度
 * @return: @[@"今天;09-08", @"周二;09-09", @"周三;09-10", @"周四;09-11"]
 */
+ (NSArray *)getFiltertimeByDay:(NSInteger)days;
/*
 *  @param: date 时间对象
 *  @return: data的描述，例如今天，周一，周二，周三，周四 ...
 */
+ (NSString *)calculateWeek:(NSDate *)date;
/// 获取月份列表
+ (NSArray *)monthList;
/// 获取指定月份的日的天数列表
+ (NSArray *)dayListByMonth:(NSInteger)month;

@end
