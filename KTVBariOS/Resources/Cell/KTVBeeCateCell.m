//
//  KTVBeeCateCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/20.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVBeeCateCell.h"

@interface KTVBeeCateCell()

@property (weak, nonatomic) IBOutlet UIImageView *beeHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation KTVBeeCateCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)invitateAction:(UIButton *)sender {
    CLog(@"-->> 约他");
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_selected_kuang"] forState:UIControlStateNormal];
    }
    
    @WeakObj(self);
    if (self.callback) {
        weakself.callback(sender.isSelected);
    }
}

@end
