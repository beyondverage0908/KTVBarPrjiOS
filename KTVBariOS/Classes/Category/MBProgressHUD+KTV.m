//
//  MBProgressHUD+KTV.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/16.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "MBProgressHUD+KTV.h"

typedef NS_ENUM(NSInteger, HUDShowType)
{
    HUDShowJustLabelType,
    HUDShowWaitType
};

@implementation MBProgressHUD (KTV)

+ (UIWindow *)window {
    return [UIApplication sharedApplication].keyWindow;
}

+ (void)show {
    [self showMessage:nil];
}

+ (void)showDelay:(NSInteger)delay {
    [self showMessage:nil hideDelay:delay toView:nil showType:HUDShowWaitType];
}

+ (void)showMessage:(NSString *)message {
    [self showMessage:message hideDelay:15 toView:nil showType:HUDShowWaitType];
}

+ (void)showSuccess:(NSString *)message {
    [self showMessage:message hideDelay:1.5 toView:nil showType:HUDShowJustLabelType];
}

+ (void)showError:(NSString *)message {
    [self showMessage:message hideDelay:1.5 toView:nil showType:HUDShowJustLabelType];
}

+ (void)hiddenHUD {
    [self hideHUDForView:nil];
}

+ (void)hideHUDForView:(UIView *)view{
    
    if (view == nil)
        view = [self window];
    
    [self hideHUDForView:view animated:YES];
}


+ (void)showMessage:(NSString *)message hideDelay:(NSInteger)delay toView:(UIView *)view showType:(HUDShowType)type{
    
    if (!view) {
        view = [self window];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // default
    hud.mode = MBProgressHUDModeIndeterminate;
    
    if (type == HUDShowWaitType) {
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    else if (type == HUDShowJustLabelType) {
        hud.mode = MBProgressHUDModeText;
    }
    
    if (message == nil || message.length == 0) {
        hud.label.text = @"";
    } else {
        hud.label.text = message;
    }
    
    [hud hideAnimated:YES afterDelay:delay];
}

@end
