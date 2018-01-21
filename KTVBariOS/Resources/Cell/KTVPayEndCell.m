//
//  KTVPayEndCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/20.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVPayEndCell.h"

@implementation KTVPayEndCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)completedAction:(id)sender {
    CLog(@"-->> 完成");
    @WeakObj(self);
    if (self.completedCallback) {
        weakself.completedCallback();
    }
}

- (IBAction)startPinZhuoAction:(id)sender {
    CLog(@"-->> 发起拼桌活动");
    @WeakObj(self);
    if (self.startPinZhuoCallback) {
        weakself.startPinZhuoCallback();
    }
}

@end
