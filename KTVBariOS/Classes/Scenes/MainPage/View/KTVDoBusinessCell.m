//
//  KTVDoBusinessCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVDoBusinessCell.h"

@interface KTVDoBusinessCell ()

@property (weak, nonatomic) IBOutlet UILabel *doBusinessTimeLabel;

@end

@implementation KTVDoBusinessCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - 设置

- (void)setStore:(KTVStore *)store {
    _store = store;
    
    self.doBusinessTimeLabel.text = [NSString stringWithFormat:@"营业时间:%@到%@", _store.fromTime, _store.toTime];
}

@end
