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
/// 移除user default
+ (void)removeUserDefaultForKey:(NSString *)key;
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

/// 获取年份列表 - 5年
+ (NSArray<NSString *> *)yearList;
/// 获取月份列表
+ (NSArray *)monthList;
/// 获取指定月份的日的天数列表
+ (NSArray *)dayListByMonth:(NSInteger)month;

#pragma mark - 图片相关

/**
 * 将图片缩放到指定的CGSize大小
 * UIImage image 原始的图片
 * CGSize size 要缩放到的大小
 */
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size;
/**
 * 根据给定的size的宽高比自动缩放原图片、自动判断截取位置,进行图片截取
 * UIImage image 原始的图片
 * CGSize size 截取图片的size
 */
+ (UIImage *)clipImage:(UIImage *)image toRect:(CGSize)size;

/// 根据videoUrl获取视频缩略图
+ (UIImage *)thumbnailFromVideoUrl:(NSString *)videoUrl;

#pragma mark - 版本相关

/// app的应用名称
+ (NSString *)appName;
///  app 版本
+ (NSString *)appVersion;
/// 系统版本
+ (NSString *)osVersion;
/// 系统名字
+ (NSString *)osName;
/// 版本和名字
+ (NSString *)osNameVersion;
/// 获取开发厂商ID
+ (NSString *)idfv;
/// 获取手机型号
+ (NSString *)phoneModel;
/// App Bundle identifier
+ (NSString *)bundleIdentifier;
/// 通过plist中获取值
+ (NSString *)plistForKey:(NSString *)key;

@end
