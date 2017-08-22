//
//  KTVIntroduceCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/16.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVIntroduceCell.h"

@interface KTVIntroduceCell ()

@property (weak, nonatomic) IBOutlet UILabel *seatLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeMesageLabel;


@end

@implementation KTVIntroduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
