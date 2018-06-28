//
//  KTVInvitingTACell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/6/24.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVInvitingTACell.h"

@interface KTVInvitingTACell()



@end

@implementation KTVInvitingTACell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)invitingTaAction:(UIButton *)sender {
    CLog(@"邀约他");
    if (_invitedCallback) {
        self.invitedCallback();
    }
}

@end
