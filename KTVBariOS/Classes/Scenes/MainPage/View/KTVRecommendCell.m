//
//  KTVRecommendCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/8.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVRecommendCell.h"

@interface KTVRecommendCell ()

@property (weak, nonatomic) IBOutlet UIImageView *toastImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation KTVRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
