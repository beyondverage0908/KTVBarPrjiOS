//
//  KTVCommonDefine.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/9.
//  Copyright © 2017年 Lin. All rights reserved.
//

#ifndef KTVCommonDefine_h
#define KTVCommonDefine_h

// log
#ifdef DEBUG
# define CLog(...) NSLog(__VA_ARGS__);
#else
# define CLog(...);
#endif

// weakSelf
#define WeakObj(o) autoreleasepool{} __weak typeof(o) weak##o = o

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)

#define iPhoneX ([UIScreen mainScreen].bounds.size.height==812.0f && [UIScreen mainScreen].bounds.size.width==375.0f)

#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

// RGB颜色创建
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define COLORHex(x) [UIColor colorHex:x]

#define KtvScreenW [UIScreen mainScreen].bounds.size.width
#define KtvScreenH [UIScreen mainScreen].bounds.size.height

// 系统方法
// NSUsetDefault
#define KtvDefaults                 [NSUserDefaults standardUserDefaults]
// NSNotificationCenter
#define KtvNotiCenter               [NSNotificationCenter defaultCenter]
// 从类获取字符串
#define KTVStringClass(cls)         NSStringFromClass([cls class])



// 对服务端状态定义
#define ktvSuccess                          @"Success"
#define ktvCode                             @"00000"
#define ktvDetail                           @"detail"
#define ktvInvalidateToken                  @"2"
#define ktvHeaderTokenNull                  @"1"
#define ktvUserHeaderDefaultImg             [UIImage imageNamed:@"bar_yuepao_user_placeholder"]

#define KTVInvalidateToken                  @"KTVInvalidateToken"


#pragma mark - 对通知的定义

#define KNotLoginSuccess                    @"KNotLoginSuccess"
#define KNotLoginOutOf                      @"KNotLoginOutOf"
#define KNotUserLocationUpdate              @"KNotUserLocationUpdate"


#endif /* KTVCommonDefine_h */
