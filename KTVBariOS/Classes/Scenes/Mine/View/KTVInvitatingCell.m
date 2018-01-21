//
//  KTVInvitatingCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/21.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVInvitatingCell.h"

@interface KTVInvitatingCell()

@property (weak, nonatomic) IBOutlet UIButton *acceptBtn;
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;


@end

@implementation KTVInvitatingCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)refuseAction:(id)sender {
    CLog(@"-->> 拒绝");
}

- (IBAction)acceptAction:(id)sender {
    CLog(@"-->> 接受");
}

@end
