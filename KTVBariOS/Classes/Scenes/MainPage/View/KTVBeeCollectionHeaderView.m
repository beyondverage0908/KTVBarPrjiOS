//
//  KTVBeeCollectionHeaderView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/21.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVBeeCollectionHeaderView.h"

@interface KTVBeeCollectionHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *beeTypeLabel;

@end

@implementation KTVBeeCollectionHeaderView

- (void)setType:(NSInteger)type {
    if (_type != type) {
        _type = type;
        
        if (_type == 0) {
            self.beeTypeLabel.text = [NSString stringWithFormat:@"-----固定暖场人-----"];
        } else if (_type == 1) {
            self.beeTypeLabel.text = [NSString stringWithFormat:@"-----常驻暖场人-----"];
        } else if (_type == 2) {
            self.beeTypeLabel.text = [NSString stringWithFormat:@"-----兼职暖场人-----"];
        }
    }
}

@end
