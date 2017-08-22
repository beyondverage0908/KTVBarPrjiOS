//
//  KTVBarKtvReserveCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBarKtvReserveCell.h"

@interface KTVBarKtvReserveCell ()

@property (weak, nonatomic) IBOutlet UILabel *moneyOldLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@end

@implementation KTVBarKtvReserveCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
  

@end
