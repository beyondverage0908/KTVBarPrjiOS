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

- (void)setActivity:(KTVActivity *)activity {
    if (_activity != activity) {
        _activity = activity;
        
        self.timeLabel.text = _activity.toTime;
        [self.toastImageView sd_setImageWithURL:[NSURL URLWithString:_activity.picture.pictureUrl] placeholderImage:[UIImage imageNamed:@"bar_detail_beauty_placeholder"]];
    }
}

@end
