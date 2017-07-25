//
//  UIButton+KTVExtension.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/7/19.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "UIButton+KTVExtension.h"

@implementation UIButton (KTVExtension)

- (void)countdownWithSeconds:(NSInteger)seconds {
    
    __block NSInteger timeout = seconds;
    
    UILabel *countdownLabel = [[UILabel alloc] initWithFrame:self.bounds];
    countdownLabel.textColor = [UIColor whiteColor];
    countdownLabel.backgroundColor = [UIColor clearColor];
    countdownLabel.textAlignment = NSTextAlignmentCenter;
    countdownLabel.font = self.titleLabel.font;
    [self addSubview:countdownLabel];
    self.enabled = NO;
    
    // 当前的button title值为空
    NSString *currentTitle = self.currentTitle;
    [self setTitle:@"" forState:UIControlStateNormal];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.enabled = YES;
                [countdownLabel removeFromSuperview];
                [self setTitle:currentTitle forState:UIControlStateNormal];
            });
        }else{
            NSString *strTime = [NSString stringWithFormat:@"%ld秒",(long)timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                countdownLabel.text = strTime;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
