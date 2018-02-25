//
//  KTVShortcutCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/2/25.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVShortcutCell.h"

// 个人信息 - 订单 - 好友 入口

@interface KTVShortcutCell()

@property (weak, nonatomic) IBOutlet UIView *orderEntrance;
@property (weak, nonatomic) IBOutlet UIView *friendEntrance;

@end

@implementation KTVShortcutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderEntranceAction)];
    [self.orderEntrance addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(friendEntranceAction)];
    [self.friendEntrance addGestureRecognizer:tap2];
}

- (void)orderEntranceAction {
    if (self.entranceCallback) {
        self.entranceCallback(0);
    }
}

- (void)friendEntranceAction {
    if (self.entranceCallback) {
        self.entranceCallback(1);
    }
}

@end
