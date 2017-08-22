//
//  KTVYuePaoUserCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/16.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVYuePaoUserCell.h"

@interface KTVYuePaoUserCell ()

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLoveLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuetaLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImage;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;


@end

@implementation KTVYuePaoUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)yuetaAction:(UIButton *)sender {
    
    CLog(@"--->>>约她");
}

@end
