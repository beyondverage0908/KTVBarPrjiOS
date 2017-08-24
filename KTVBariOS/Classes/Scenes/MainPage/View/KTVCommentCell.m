//
//  KTVCommonCell.m
//  KTVBariOS
//
//  Created by pingjun lin on 2017/8/13.
//  Copyright © 2017年 Lin. All rights reserved.
//

#import "KTVCommentCell.h"
#import "KTVStarView.h"

@interface KTVCommentCell ()

@property (weak, nonatomic) IBOutlet KTVStarView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;

@end

@implementation KTVCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CLog(@"--->>> star number --->>> %@", @(self.starView.subviews.count));

    self.starView.stars = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
