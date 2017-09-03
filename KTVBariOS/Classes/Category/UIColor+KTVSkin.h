//
//  UIColor+KTVSkin.h
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KTVSkin)

/// 主题粉红色
+ (UIColor *)ktvRed;

/// 输入框占位符字体颜色
+ (UIColor *)ktvPlaceHolder;

/// 主要背景色
+ (UIColor *)ktvBG;

/// 表格分割 宽条背景色
+ (UIColor *)ktvSeparateBG;

/// 过滤器 - 时间 选中的颜色
+ (UIColor *)ktvFilterColor;

/// 项目中主题灰色
+ (UIColor *)ktvGray;

/// 主题金色
+ (UIColor *)ktvGold;

/// 主题紫色
+ (UIColor *)ktvPurple;

/// 主题textField的色
+ (UIColor *)ktvTextFieldBg;

@end
