//
//  KTVUserSenseCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/9/5.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVUserSenseCell.h"

@interface KTVUserSenseCell ()

@property (weak, nonatomic) IBOutlet UILabel *xinzuoLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhiyeLabel;
@property (weak, nonatomic) IBOutlet UILabel *loveSenseLabel;
@property (weak, nonatomic) IBOutlet UILabel *havesexLabel;
@property (weak, nonatomic) IBOutlet UILabel *manyiLabel;
@property (weak, nonatomic) IBOutlet UILabel *qianmingLabel;

@end

@implementation KTVUserSenseCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - 事件

- (IBAction)toSeeAction:(id)sender {
    CLog(@"-- 去查看");
}
@end
