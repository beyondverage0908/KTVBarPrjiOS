//
//  KTVApplyWarmerParttwoView.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/1/28.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVApplyWarmerParttwoView.h"

@interface KTVApplyWarmerParttwoView()

@property (weak, nonatomic) IBOutlet UILabel *depositLabel; // 需要缴纳保证金
@property (weak, nonatomic) IBOutlet UIView *week1;
@property (weak, nonatomic) IBOutlet UIView *week2;
@property (weak, nonatomic) IBOutlet UIView *week3;
@property (weak, nonatomic) IBOutlet UIView *week4;
@property (weak, nonatomic) IBOutlet UIView *week5;
@property (weak, nonatomic) IBOutlet UIView *week6;
@property (weak, nonatomic) IBOutlet UIView *week7;

@property (weak, nonatomic) IBOutlet UIImageView *igweek1;
@property (weak, nonatomic) IBOutlet UIImageView *igweek2;
@property (weak, nonatomic) IBOutlet UIImageView *igweek3;
@property (weak, nonatomic) IBOutlet UIImageView *igweek4;
@property (weak, nonatomic) IBOutlet UIImageView *igweek5;
@property (weak, nonatomic) IBOutlet UIImageView *igweek6;
@property (weak, nonatomic) IBOutlet UIImageView *igweek7;

@property (weak, nonatomic) IBOutlet UITextField *partMoneyTF;

@end

@implementation KTVApplyWarmerParttwoView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CLog(@"-->> 111");
}

- (IBAction)parttimeAction:(UIButton *)sender {
    CLog(@"--->>> 兼职");
}
- (IBAction)longtimeAction:(UIButton *)sender {
    CLog(@"--->>> 全职");
}

- (IBAction)agreeProtocolAction:(UIButton *)sender {
    CLog(@"--- 同意协议");
    [sender setSelected:!sender.isSelected];
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"app_gou_red"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"app_kuang_red"] forState:UIControlStateNormal];
    }
}

- (IBAction)linkCompanyAction:(id)sender {
    CLog(@"联系我们");
}

@end
