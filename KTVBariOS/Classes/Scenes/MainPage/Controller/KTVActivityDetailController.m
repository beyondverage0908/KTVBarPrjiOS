
//
//  KTVActivityDetailController.m
//  KTVBariOS
//
//  Created by pingjun lin on 2018/6/11.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "KTVActivityDetailController.h"

@interface KTVActivityDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *activityDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;


@end

@implementation KTVActivityDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.activity.title;
    
    self.startTimeLabel.text = [NSString stringWithFormat:@"开始时间: %@", _activity.fromTime];
    self.endTimeLable.text = [NSString stringWithFormat:@"结束时间: %@", _activity.toTime];
    self.activityDescriptionLabel.text = [NSString stringWithFormat:@"活动详情: %@", _activity.content];
    [self.activityImageView sd_setImageWithURL:[NSURL URLWithString:_activity.picture.pictureUrl]
                              placeholderImage:[UIImage imageNamed:@"bar_detail_beauty_placeholder"]];
}

@end
