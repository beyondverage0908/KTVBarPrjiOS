//
//  KTVAddYaoYueView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/4.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVAddYaoYueView.h"

@interface KTVAddYaoYueView ()

@property (weak, nonatomic) IBOutlet UIButton *barYueAction;
@property (weak, nonatomic) IBOutlet UIView *maskView;

@end

@implementation KTVAddYaoYueView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskTapAction:)];
    [self.maskView addGestureRecognizer:tap];
}


- (void)maskTapAction:(UIView *)mask {
    [self removeFromSuperview];
}

- (IBAction)barYueAction:(UIButton *)sender {
    CLog(@"-- 酒吧邀约");
    [self removeFromSuperview];
    if (self.yaoYueCallback) {
        self.yaoYueCallback(@"bar");
    }
}

- (IBAction)ktvYueAction:(UIButton *)sender {
    CLog(@"-- ktv邀约");
    [self removeFromSuperview];
    if (self.yaoYueCallback) {
        self.yaoYueCallback(@"ktv");
    }
}

@end
