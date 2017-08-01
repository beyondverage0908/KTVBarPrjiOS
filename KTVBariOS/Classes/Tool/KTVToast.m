//
//  VHSToast.m
//  GongYunTong
//
//  Created by pingjun lin on 16/9/20.
//  Copyright © 2016年 vhs_health. All rights reserved.
//

#import "KTVToast.h"

@interface KTVToast ()

@property (nonatomic, assign) BOOL talking;

@end

#define DEFAULT_DURATION_INTERVAL       2.0

@implementation KTVToast

- (void)setDuration:(NSTimeInterval)duration {
    _duration = duration;
}

+ (KTVToast *)shareToast {
    static KTVToast *toast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toast = [[KTVToast alloc] init];
    });
    return toast;
}

+ (void)toast:(NSString *)msg {
    [[KTVToast shareToast] showToast:msg];
}

- (void)showToast:(NSString *)msg {
    if (self.talking) {
        return;
    }
    self.talking = YES;
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    label.text = msg;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.backgroundColor = RGBACOLOR(0.0, 0.0, 0.0, 0.8);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    CGSize size = [label sizeThatFits:CGSizeMake(30, 50)];
    size.width = size.width + 40;
    label.frame = CGRectMake(0, 0, size.width, 70.0);
    
    if (size.width >= SCREENW) {
        label.numberOfLines = 0;
        label.frame = CGRectMake(0, 0, SCREENW - 100, 70 * 2);
    }
    
    label.center = window.center;
    label.layer.cornerRadius = 10.0;
    label.layer.masksToBounds = YES;
    
    [window addSubview:label];
    
    NSTimeInterval decisionInterval = self.duration ? self.duration : DEFAULT_DURATION_INTERVAL;
    
    NSTimeInterval animationsDuration = decisionInterval / 2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationsDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:animationsDuration animations:^{
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
            self.talking = NO;
        }];
    });
}

@end
