//
//  KTVPZStoreCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/3.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVPZStoreCell.h"
#import "KTVStarView.h"

@interface KTVPZStoreCell ()

@property (weak, nonatomic) IBOutlet KTVStarView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *storeHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel; //报名人数
@property (weak, nonatomic) IBOutlet UILabel *dielineLabel; // 截止报名时间 yyyy/MM/dd
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation KTVPZStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
