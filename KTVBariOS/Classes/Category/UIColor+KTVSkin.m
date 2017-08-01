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
    return [UIColor colorWithRed:34.0f / 255.0f green:34.0f / 255.0f blue:34.0f / 255.0f alpha:1.0f];
}

@end
