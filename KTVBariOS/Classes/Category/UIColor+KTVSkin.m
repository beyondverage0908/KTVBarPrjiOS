//
//  UIColor+KTVSkin.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/14.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "UIColor+KTVSkin.h"

@implementation UIColor (KTVSkin)

+ (UIColor *)ktvRed {
    // #f73982
    return [UIColor colorWithRed:247.0f / 255.0f green:57.0f / 255.0f blue:130.0f / 255.0f alpha:1.0f];
}

+ (UIColor *)ktvPlaceHolder {
    // #aaa4a5
    return [UIColor colorWithRed:170.0f / 255.0f green:164.0f / 255.0f blue:165.0f / 255.0f alpha:1.0f];
}

+ (UIColor *)ktvBG {
    /// #222222
    return [UIColor colorWithRed:34.0f / 255.0f green:31.0f / 255.0f blue:41.0f / 255.0f alpha:1.0f];
}

// 26 26 35
+ (UIColor *)ktvSeparateBG {
    /// #222222
    return [UIColor colorWithRed:26.0f / 255.0f green:26.0f / 255.0f blue:35.0f / 255.0f alpha:1.0f];
}

+ (UIColor *)ktvFilterColor {
    return [UIColor colorWithRed:75.0f / 255.0f green:85.0f / 255.0f blue:158.0f / 255.0f alpha:1.0f];
}

+ (UIColor *)ktvGray {
    return [UIColor colorWithRed:96.0f / 255.0f green:96.0f / 255.0f blue:106.0f / 255.0f alpha:1.0f];
}

// 黄金颜色
+ (UIColor *)ktvGold {
    return [UIColor colorWithRed:255.0f / 255.0f green:127.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f];
}

+ (UIColor *)ktvPurple {
    return [UIColor colorWithRed:136.0f / 255.0f green:59.0f / 255.0f blue:176.0f / 255.0f alpha:1.0f];
}

+ (UIColor *)ktvTextFieldBg {
    return [UIColor colorWithRed:26.0f / 255.0f green:26.0f / 255.0f blue:35.0f / 255.0f alpha:1.0f];
}

@end
