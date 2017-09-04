//
//  KTVUserInfoCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/4.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUserInfoCell.h"

@interface KTVUserInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation KTVUserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setInfo:(NSString *)info {
    _info = info;
    self.infoLabel.text = _info;
}

@end
