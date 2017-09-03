//
//  KTVOrderConfirmCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/29.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVOrderConfirmCell.h"

@interface KTVOrderConfirmCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation KTVOrderConfirmCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
