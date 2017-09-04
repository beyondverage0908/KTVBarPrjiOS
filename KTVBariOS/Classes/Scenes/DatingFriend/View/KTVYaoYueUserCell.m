//
//  KTVYaoYueUserCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/4.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVYaoYueUserCell.h"

@interface KTVYaoYueUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel; // 当前在约的状态
@property (weak, nonatomic) IBOutlet UILabel *tipLabel; // 用户宣言

@end

@implementation KTVYaoYueUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)yueTaAction:(UIButton *)sender {
    CLog(@"-- 约TA");
}

@end
