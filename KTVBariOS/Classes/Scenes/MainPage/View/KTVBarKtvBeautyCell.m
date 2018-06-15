//
//  KTVBarKtvBeautyCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVBarKtvBeautyCell.h"

@interface KTVBarKtvBeautyCell ()

@property (weak, nonatomic) IBOutlet UIImageView *beautyImageView;

@end

@implementation KTVBarKtvBeautyCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setActivity:(KTVActivity *)activity {
    if (_activity != activity) {
        _activity = activity;
        
        [self.beautyImageView sd_setImageWithURL:[NSURL URLWithString:_activity.picture.pictureUrl] placeholderImage:[UIImage imageNamed:@"bar_detail_beauty_placeholder"]];
    }
}

@end
