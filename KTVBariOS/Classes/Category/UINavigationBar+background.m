//
//  UINavigationBar+background.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/23.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "UINavigationBar+background.h"
#import <objc/runtime.h>

@implementation UINavigationBar (background)

static char overlayKey;

- (UIView *)overlay {
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay {
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ktv_setBackgroundColor:(UIColor *)backgroundColor {
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        // insert an overlay into the view hierarchy
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 20)];
        self.overlay.userInteractionEnabled = YES;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}


- (void)setColor:(UIColor *)color {
    UIView *bgView = nil;
    if (!iPhoneX){
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 20)];
    } else {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -44, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 44)];
    }
    bgView.backgroundColor = color;
    
    if (![color isEqual:[UIColor clearColor]]) {
        UIView *bottomLine = nil;
        if (!iPhoneX) {
             bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame) + 20 - 1, CGRectGetWidth(bgView.frame), 1)];
        } else {
            bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame) + 44 - 1, CGRectGetWidth(bgView.frame), 1)];
        }
        bottomLine.backgroundColor = [UIColor ktvSeparateBG];
        bottomLine.layer.shadowOffset = CGSizeMake(CGRectGetWidth(bgView.frame), 2);
        bottomLine.layer.shadowColor = color.CGColor;
        [bgView addSubview:bottomLine];
    }
    
    [self setValue:bgView forKey:@"backgroundView"];
}

@end
