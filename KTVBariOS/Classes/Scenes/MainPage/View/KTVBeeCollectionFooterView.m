//
//  KTVBeeCollectionFooterView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/21.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVBeeCollectionFooterView.h"

@interface KTVBeeCollectionFooterView()

@end

@implementation KTVBeeCollectionFooterView

- (IBAction)seeMoreBeeAction:(id)sender {
    CLog(@"-->> 查看更多暖场人");
    
    @WeakObj(self);
    if (self.findMoreCallback) {
        weakself.findMoreCallback(weakself.type);
    }
}
@end
